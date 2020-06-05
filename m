From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Date: Thu, 04 Jun 2020 21:07:46 -0700
Message-ID: <2f93895709e5837c3b6f38a753057505a9d48ac4.camel@perches.com>
References: <202006031539.4198EA6@keescook>
         <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
         <202006041451.19491ECA@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:40948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgFEEHu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 00:07:50 -0400
In-Reply-To: <202006041451.19491ECA@keescook>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Thu, 2020-06-04 at 14:52 -0700, Kees Cook wrote:
> On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> > On Wed, 2020-06-03 at 15:40 -0700, Kees Cook wrote:
> > > The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> > > lead to skipping this code.
> > > 
> > > Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/pwm/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 9973c442b455..6b3cbc0490c6 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
> > >  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> > >  		trace_pwm_get(pwm, &pwm->state);
> > >  
> > > -		if (IS_ENABLED(PWM_DEBUG))
> > > +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
> > >  			pwm->last = pwm->state;
> > >  	}
> > >  
> > > -- 
> > > 2.25.1
> > > 
> > 
> > more odd uses (mostly in comments)
> > 
> > $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
> >   sed -r 's/\s+//g'| \
> >   grep -v '(CONFIG_' | \
> >   sort | uniq -c | sort -rn
> >       7 IS_ENABLED(DEBUG)
> >       4 IS_ENABLED(DRM_I915_SELFTEST)
> >       4 IS_ENABLED(cfg)
> >       2 IS_ENABLED(opt_name)
> >       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
> >       2 IS_ENABLED(config)
> >       2 IS_ENABLED(cond)
> >       2 IS_ENABLED(__BIG_ENDIAN)
> >       1 IS_ENABLED(x)
> >       1 IS_ENABLED(STRICT_KERNEL_RWX)
> >       1 IS_ENABLED(PWM_DEBUG)
> >       1 IS_ENABLED(option)
> >       1 IS_ENABLED(ETHTOOL_NETLINK)
> >       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
> >       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
> > 
> > STRICT_KERNEL_RWX is misused here in ppc
> > 
> > ---
> > 
> > Fix pr_warn without newline too.
> > 
> >  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> > index 51e3c15f7aff..dd60c5f2b991 100644
> > --- a/arch/powerpc/mm/book3s64/hash_utils.c
> > +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> > @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
> >  		 * Pick a size for the linear mapping. Currently, we only
> >  		 * support 16M, 1M and 4K which is the default
> >  		 */
> > -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> > +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
> >  		    (unsigned long)_stext % 0x1000000) {
> >  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> > -				pr_warn("Kernel not 16M aligned, "
> > -					"disabling 16M linear map alignment");
> > +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
> >  			aligned = false;
> >  		}
> 
> Joe, I was going to send all of the fixes for these issues, but your
> patch doesn't have a SoB. Shall I add one for the above patch?

<shrug> sure if you want, or submit it yourself.

My feeling about these types of changes is the maintainers
of the subsystems, in this case ppc, should manage this
themselves and shouldn't require anyone else to actually
bother to send real patches.
