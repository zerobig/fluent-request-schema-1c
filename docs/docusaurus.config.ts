import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: '1С Предприятие. Fluent запросы',
  tagline: 'Dinosaurs are cool',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://zerobig.github.io',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/fluent-request-schema-1c',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'zerobig',
  projectName: 'fluent-request-schema-1c',

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'ru',
    locales: ['ru'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          sidebarCallapsible: false,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/zerobig/fluent-request-schema-1c/tree/main/packages/create-docusaurus/templates/shared/',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  plugins: [
    [
      '@docusaurus/plugin-content-docs',
      {
        id: 'api',
        path: 'api',
        routeBasePath: 'api',
        sidebarPath: './sidebarsAPI.ts',
        // ... other options
      },
    ],
  ],

  themeConfig: {
    // Replace with your project's social card
    navbar: {
      title: '1С Предприятие. Fluent запросы',
      logo: {
        alt: 'Логотип',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'getting-started/index',
          position: 'left',
          label: 'Начало работы',
        },
        {
          type: 'docSidebar',
          sidebarId: 'api',
          docsPluginId: 'api',
          position: 'left',
          label: 'API',
        },
        {
          href: 'https://github.com/zerobig/fluent-request-schema-1c',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Документация',
          items: [
            {
              label: 'Начало',
              to: '/docs/getting-started',
            },
          ],
        },
        {
          title: 'Обратная связь',
          items: [
            {
              label: 'Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/fluent-request-schema-1c',
            },
            {
              label: 'GitHub Issues',
              href: 'https://github.com/zerobig/fluent-request-schema-1c/issues',
            },
          ],
        },
        {
          title: 'Ещё',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/zerobig/fluent-request-schema-1c',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Бушин Илья. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bsl', 'json'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
