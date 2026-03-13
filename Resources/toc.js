/**
 * Table of Contents (TOC) for Palette Theme
 * v8: Fixed Layout Integrity, Calculated Alignment, and Hierarchical Colors.
 */
(function () {
    'use strict';

    /**
     * Inject necessary CSS styles for TOC.
     */
    const injectTOCStyles = () => {
        if (document.getElementById('palette-toc-styles')) return;

        const style = document.createElement('style');
        style.id = 'palette-toc-styles';
        style.textContent = `
            :root {
                --toc-accent: #7cafc2;
                --toc-zinc-100: #f4f4f5;
                --toc-zinc-200: #e4e4e7;
                --toc-zinc-300: #d4d4d8;
                --toc-zinc-400: #a1a1aa;
                --toc-zinc-500: #71717a;
                --toc-zinc-800: #27272a;
                --toc-zinc-900: #18181b;
            }

            #toc-container {
                margin: 2rem 0;
                padding: 1rem 0;
                transition: opacity 0.3s ease;
            }

            /* --- 1. Global Base Styles --- */
            h2, h3 {
                scroll-margin-top: 16px;
            }

            #toc-container.hidden { display: none; }

            .toc-title {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 0.65rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.15em;
                color: var(--toc-zinc-400);
                margin: 0;
                padding: 0;
                background: none;
                border: none;
                user-select: none;
            }

            .toc-title::before {
                content: "→"; 
                display: inline-block;
                font-size: 0.8rem;
                transition: transform 0.3s ease;
                color: var(--toc-accent);
                margin-right: 0.6rem;
            }

            .toc-list {
                list-style: none;
                padding: 0;
                margin: 0;
                display: none; 
            }

            .toc-link {
                display: block;
                font-size: 0.85rem;
                line-height: 1.5;
                text-decoration: none !important;
                transition: all 0.2s ease;
            }

            /* --- 2. Mobile Specific Styles --- */
            @media (max-width: 1365px) {
                #toc-container {
                    border-top: 1px solid var(--toc-zinc-300);
                    border-bottom: 1px solid var(--toc-zinc-300);
                    padding: 1.25rem 0;
                    margin: 3rem 0;
                }
                @media (prefers-color-scheme: dark) {
                    #toc-container { border-color: rgba(63, 63, 70, 0.8); }
                }
                .toc-title { cursor: pointer; }
                
                .toc-link { padding: 0.6rem 0; background: transparent !important; }
                .toc-h2 .toc-link { color: var(--toc-zinc-900); font-weight: 600; }
                .toc-h3 .toc-link { color: var(--toc-zinc-500); padding-left: 1.25rem; }

                @media (prefers-color-scheme: dark) {
                    .toc-h2 .toc-link { color: var(--toc-zinc-100) !important; }
                    .toc-h3 .toc-link { color: var(--toc-zinc-400) !important; }
                }

                .toc-link:active { color: var(--toc-accent) !important; }
                
                #toc-container.expanded .toc-title { margin-bottom: 1.25rem; }
                #toc-container.expanded .toc-title::before { transform: rotate(90deg); }
                #toc-container.expanded .toc-list { display: block; }
            }

            /* --- 3. Desktop Specific Styles --- */
            @media (min-width: 1366px) and (max-height: 400px) {
                #toc-container { display: none; }
            }

            @media (min-width: 1366px) {
                #toc-container {
                    position: fixed;
                    top: 10rem; 
                    left: calc(50% + 25rem); 
                    width: 250px;
                    margin: 0;
                    max-height: calc(100vh - 10rem);
                    overflow-y: auto;
                    scrollbar-width: none;
                }
                #toc-container::-webkit-scrollbar { display: none; }

                .toc-title { cursor: default; margin-bottom: 1rem; }
                .toc-title::before { display: none; }

                .toc-list { 
                    display: block; 
                    border-left: 1.5px solid var(--toc-zinc-200);
                }
                @media (prefers-color-scheme: dark) {
                    .toc-list { border-left-color: rgba(255, 255, 255, 0.1); }
                }

                .toc-link {
                    padding: 0.45rem 1.25rem;
                    margin-left: -1.5px;
                    border-left: 2px solid transparent;
                }
                .toc-h2 .toc-link { color: var(--toc-zinc-800); font-weight: 600; }
                .toc-h3 .toc-link { color: var(--toc-zinc-500); padding-left: 2.25rem; }

                @media (prefers-color-scheme: dark) {
                    .toc-h2 .toc-link { color: var(--toc-zinc-100); }
                    .toc-h3 .toc-link { color: var(--toc-zinc-400); }
                }

                /* Hover only on Desktop */
                @media (hover: hover) {
                    .toc-link:hover {
                        color: var(--toc-accent);
                        border-left-color: var(--toc-zinc-300);
                        background: linear-gradient(to right, rgba(124, 175, 194, 0.05), transparent);
                    }
                    @media (prefers-color-scheme: dark) {
                        .toc-link:hover { 
                            border-left-color: var(--toc-zinc-500);
                            background: linear-gradient(to right, rgba(124, 175, 194, 0.08), transparent); 
                        }
                    }
                }

                /* Desktop Active Slider */
                .toc-item.active .toc-link {
                    color: var(--toc-accent) !important;
                    font-weight: 700;
                    border-left-color: var(--toc-accent);
                    background: linear-gradient(to right, rgba(124, 175, 194, 0.12), transparent);
                }
                @media (prefers-color-scheme: dark) {
                    .toc-item.active .toc-link {
                        color: #fff !important;
                        background: linear-gradient(to right, rgba(124, 175, 194, 0.18), transparent);
                    }
                }
            }

            @media (prefers-reduced-motion: no-preference) {
                html { scroll-behavior: smooth; }
            }
        `;
        document.head.appendChild(style);
    };

    const generateId = (text) => {
        return text.toLowerCase().trim()
            .replace(/\s+/g, '-')
            .replace(/[^\w\u4e00-\u9fa5-]+/g, '')
            .replace(/-+/g, '-')
            .replace(/^-+|-+$/g, '');
    };

    const initTOC = () => {
        const container = document.getElementById('toc-container');
        const content = document.querySelector('.content');
        if (!container || !content) return;

        const headings = Array.from(content.querySelectorAll('h2, h3'));
        if (headings.length < 2) {
            container.classList.add('hidden');
            return;
        }

        injectTOCStyles();
        container.innerHTML = '';

        const title = document.createElement('button');
        title.className = 'toc-title';
        title.innerText = 'Contents';
        title.setAttribute('aria-expanded', 'false');
        container.appendChild(title);

        const list = document.createElement('ul');
        list.className = 'toc-list';

        const tocItems = [];

        const usedIds = new Set(headings.filter(h => h.id).map(h => h.id));

        headings.forEach((heading) => {
            if (!heading.id) {
                let baseId = generateId(heading.innerText) || 'section';
                let uniqueId = baseId;
                let counter = 2;
                while (usedIds.has(uniqueId)) {
                    uniqueId = `${baseId}-${counter++}`;
                }
                heading.id = uniqueId;
                usedIds.add(uniqueId);
            }

            const item = document.createElement('li');
            item.className = 'toc-item';
            const tagName = heading.tagName.toLowerCase();
            item.classList.add(`toc-${tagName}`);

            const link = document.createElement('a');
            link.className = 'toc-link';
            link.href = `#${heading.id}`;
            link.innerText = heading.innerText;

            item.appendChild(link);
            list.appendChild(item);
            
            tocItems.push({ heading, tocItem: item });
        });

        container.appendChild(list);

        /**
         * Dynamically align TOC with the article meta (date/tags).
         */
        const alignTOCToContent = () => {
            if (window.innerWidth >= 1366) {
                const meta = document.querySelector('.article-meta');
                if (meta) {
                    const metaDocTop = meta.getBoundingClientRect().top + window.scrollY;
                    const headerHeight = 80;
                    const topValue = Math.max(headerHeight, metaDocTop);
                    container.style.top = `${topValue}px`;
                    container.style.maxHeight = `calc(100vh - ${topValue}px - 48px)`;
                }
            } else {
                container.style.top = '';
                container.style.maxHeight = '';
            }
        };

        title.addEventListener('click', () => {
            if (window.innerWidth < 1366) {
                const expanded = container.classList.toggle('expanded');
                title.setAttribute('aria-expanded', String(expanded));
            }
        });

        const updateActiveState = () => {
            const scrollPos = window.scrollY;
            const headerOffset = 120; 

            let activeIndex = -1;
            for (let i = 0; i < tocItems.length; i++) {
                const headingDocTop = tocItems[i].heading.getBoundingClientRect().top + window.scrollY;
                if (headingDocTop <= scrollPos + headerOffset) {
                    activeIndex = i;
                } else {
                    break;
                }
            }

            tocItems.forEach((item, index) => {
                if (index === activeIndex) {
                    item.tocItem.classList.add('active');
                    if (window.innerWidth >= 1366) {
                        const itemTop = item.tocItem.offsetTop;
                        const itemBottom = itemTop + item.tocItem.offsetHeight;
                        if (itemTop < container.scrollTop) {
                            container.scrollTop = itemTop;
                        } else if (itemBottom > container.scrollTop + container.clientHeight) {
                            container.scrollTop = itemBottom - container.clientHeight;
                        }
                    }
                } else {
                    item.tocItem.classList.remove('active');
                }
            });
        };

        let ticking = false;
        window.addEventListener('scroll', () => {
            if (!ticking) {
                requestAnimationFrame(() => {
                    updateActiveState();
                    ticking = false;
                });
                ticking = true;
            }
        }, { passive: true });
        window.addEventListener('resize', () => {
            updateActiveState();
            alignTOCToContent();
        });
        
        alignTOCToContent();
        updateActiveState(); 
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initTOC);
    } else {
        initTOC();
    }
})();