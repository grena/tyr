<?php

declare(strict_types=1);

namespace Heavymind\Tyr\Infrastructure\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Finder\Finder;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Yaml\Yaml;

class HomeController extends AbstractController
{
    public function __construct(private string $projectDir)
    {
    }

    /**
     * @Route("/find", name="find", options={"expose"=true})
     */
    public function find(Request $request, ): Response
    {
        $file = $request->get('file');
        $software = $request->get('software');
        $version = $request->get('version');

        $commands = $this->getCommands($file, $software, $version);

        if (empty($commands)) {
            return new Response("\nNo commands found to run this test! Feel free to add instructions on how to run it: https://github.com/grena/tyr/blob/main/README.md\n\n", Response::HTTP_NOT_FOUND);
        }

        $stringCommands = implode("\n", $commands);

        $response = <<<REPONSE

$stringCommands


REPONSE;

        return new Response($response);
    }

    private function getInstructions(): array
    {
        $finder = new Finder();
        $finder->files()->in($this->projectDir.'/config/instructions');
        $instructions = [];

        foreach ($finder as $file) {
            $instructions[] = Yaml::parse(file_get_contents($file->getRealPath()));
        }

        return $instructions;
    }

    private function getCommands(string $file, string $software, string $version): array
    {
        $instructions = $this->getInstructions();

        $softwareVersionInstruction = current(array_filter($instructions, function ($instruction) use ($file, $software, $version) {
            return $instruction['software'] === $software && $instruction['version'] === $version;
        }));

        foreach ($softwareVersionInstruction['data'] as $data) {
            foreach ($data['folders'] as $folder) {
                if (str_starts_with($file, $folder)) {
                    return array_map(function ($command) use ($file) {
                        return str_replace('{{FILEPATH}}', $file, $command);
                    }, $data['commands']);
                }
            }
        }

        return [];
    }
}
