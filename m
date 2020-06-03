From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Date: Wed, 3 Jun 2020 16:38:32 -0700
Message-ID: <202006031634.477F65AC53@keescook>
References: <202006031539.4198EA6@keescook>
 <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFCXie (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 19:38:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0DC08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 16:38:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so2476475pfa.12
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 16:38:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> more odd uses (mostly in comments)
> 
> $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
>   sed -r 's/\s+//g'| \
>   grep -v '(CONFIG_' | \
>   sort | uniq -c | sort -rn

I think a missed a bunch because my grep was messy. :) This is much
easier to scan.

>       7 IS_ENABLED(DEBUG)
>       4 IS_ENABLED(cfg)
>       2 IS_ENABLED(opt_name)
>       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
>       2 IS_ENABLED(config)
>       2 IS_ENABLED(cond)
>       2 IS_ENABLED(__BIG_ENDIAN)
>       1 IS_ENABLED(x)
>       1 IS_ENABLED(PWM_DEBUG)
>       1 IS_ENABLED(option)
>       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
>       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)

These seem to be "as expected".

>       4 IS_ENABLED(DRM_I915_SELFTEST)
>       1 IS_ENABLED(STRICT_KERNEL_RWX)
>       1 IS_ENABLED(ETHTOOL_NETLINK)

But these are not.

> 
> STRICT_KERNEL_RWX is misused here in ppc
> 
> ---
> 
> Fix pr_warn without newline too.
> 
>  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 51e3c15f7aff..dd60c5f2b991 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
>  		 * Pick a size for the linear mapping. Currently, we only
>  		 * support 16M, 1M and 4K which is the default
>  		 */
> -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
>  		    (unsigned long)_stext % 0x1000000) {
>  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> -				pr_warn("Kernel not 16M aligned, "
> -					"disabling 16M linear map alignment");
> +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
>  			aligned = false;
>  		}

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
