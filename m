From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pwm: fix Broadcom BCM7038 PWM driver
Date: Wed, 07 Oct 2015 15:31:07 +0200
Message-ID: <51655489.62UKkKA6xS@wuerfel>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com> <6796852.Ynn1zMqb4r@wuerfel> <56146C92.7090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56146C92.7090606@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar
List-Id: linux-pwm@vger.kernel.org

On Tuesday 06 October 2015 17:51:30 Florian Fainelli wrote:
> On 06/10/15 12:59, Arnd Bergmann wrote:
> > The newly added pwm-brcmstb driver fails to build if CONFIG_PM_SLEEP
> > is enabled:
> > 
> > drivers/pwm/pwm-brcmstb.c: In function 'brcmstb_pwm_suspend':
> > drivers/pwm/pwm-brcmstb.c:309:42: error: 'dev' undeclared (first use in this function)
> >   struct brcmstb_pwm *p = dev_get_drvdata(dev);
> > 
> > This changes the name of the function argument to match its user.
> 
> Thanks, maybe, to avoid similar issues in the future, we should start
> removing the ifdef CONFIG_PM_SLEEP and instead annotate such functions
> with __maybe_unused. I wonder if we could magically make that happen
> with a coccinelle script that looks for SIMPLE_DEV_PM_OPS to know which
> functions to annotate... humm.

I think the best solution would be to replace SIMPLE_DEV_PM_OPS with
a macro that creates an unused reference to the functions. That
way, we could remove all the #ifdef CONFIG_PM_SLEEP from the kernel,
but we'd still have to use coccinelle to replace all the current
instances with the new macro.

	Arnd
