/**
 * Code Copy Feature for Palette Theme
 */
(function () {
    'use strict';

    // 1. Inject styles once
    const injectStyles = () => {
        if (document.getElementById('palette-code-copy-styles')) return;

        const style = document.createElement('style');
        style.id = 'palette-code-copy-styles';
        style.textContent = `
            .code-block-container {
                position: relative;
                margin: 1.5rem 0;
            }
            .copy-code-button {
                position: absolute;
                top: 0.6rem;
                right: 0.6rem;
                padding: 0.3rem 0.6rem;
                font-size: 0.75rem;
                line-height: 1;
                color: #e2e8f0;
                background-color: rgba(71, 85, 105, 0.75);
                border: 1px solid rgba(226, 232, 240, 0.1);
                border-radius: 0.375rem;
                cursor: pointer;
                opacity: 0;
                transition: opacity 0.2s cubic-bezier(0.4, 0, 0.2, 1), 
                            background-color 0.2s ease,
                            transform 0.1s ease;
                z-index: 20;
                user-select: none;
                -webkit-user-select: none;
            }
            .code-block-container:hover .copy-code-button,
            .code-block-container:focus-within .copy-code-button {
                opacity: 1;
            }
            .copy-code-button:hover {
                background-color: rgba(51, 65, 85, 0.9);
                transform: scale(1.02);
            }
            .copy-code-button:active {
                transform: scale(0.95);
            }
            .copy-code-button.success {
                background-color: rgba(34, 197, 94, 0.9);
                color: #ffffff;
                border-color: rgba(34, 197, 94, 0.2);
            }
            /* Ensure the button doesn't overlap text if pre is small */
            pre {
                position: relative;
                z-index: 10;
            }
        `;
        document.head.appendChild(style);
    };

    /**
     * Main initialization function
     */
    const init = () => {
        // Feature detection
        if (!navigator.clipboard) {
            console.warn('Clipboard API not supported in this browser.');
            return;
        }

        const codeBlocks = document.querySelectorAll('pre');
        if (codeBlocks.length === 0) return;

        injectStyles();

        codeBlocks.forEach((pre) => {
            // Avoid duplicate initialization
            if (pre.parentElement.classList.contains('code-block-container')) return;

            // 2. Wrap the pre element
            const wrapper = document.createElement('div');
            wrapper.className = 'code-block-container';
            
            if (pre.parentNode) {
                pre.parentNode.insertBefore(wrapper, pre);
                wrapper.appendChild(pre);
            }

            // 3. Create and append the copy button
            const button = document.createElement('button');
            button.className = 'copy-code-button';
            button.type = 'button';
            button.innerText = 'Copy';
            button.setAttribute('aria-label', 'Copy code to clipboard');
            
            wrapper.appendChild(button);

            // 4. Click event with modern async/await
            button.addEventListener('click', async () => {
                const codeElement = pre.querySelector('code') || pre;
                const textToCopy = codeElement.innerText;

                try {
                    await navigator.clipboard.writeText(textToCopy);
                    
                    // Feedback UI
                    button.innerText = 'Copied!';
                    button.classList.add('success');
                    button.disabled = true;

                    setTimeout(() => {
                        button.innerText = 'Copy';
                        button.classList.remove('success');
                        button.disabled = false;
                    }, 2000);
                } catch (err) {
                    console.error('Palette Theme: Failed to copy text', err);
                    button.innerText = 'Error';
                    
                    setTimeout(() => {
                        button.innerText = 'Copy';
                    }, 2000);
                }
            });
        });
    };

    // Run when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
