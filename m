From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/2] pwm: lpss: properly split driver to parts
Date: Mon, 25 Aug 2014 11:11:17 +0300
Message-ID: <1408954277.30155.0.camel@linux.intel.com>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1408465056-8605-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140822111343.GA3825@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22548 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965AbaHYILU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 25 Aug 2014 04:11:20 -0400
In-Reply-To: <20140822111343.GA3825@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>

On Fri, 2014-08-22 at 13:13 +0200, Thierry Reding wrote:
> On Tue, Aug 19, 2014 at 07:17:35PM +0300, Andy Shevchenko wrote:
> [...]
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> [...]
> > +config PWM_LPSS_PCI
> > +	tristate "Intel LPSS PWM PCI driver"
> > +	depends on PCI
> > +	select PWM_LPSS
> [...]
> > +config PWM_LPSS_PLATFORM
> > +	tristate "Intel LPSS PWM platform driver"
> > +	depends on ACPI
> > +	select PWM_LPSS
> 
> I changed both of the above select PWM_LPSS to depends on PWM_LPSS
> because that makes them show up in a more meaningful way in menuconfig
> and otherwise it looks weird if the PWM_LPSS shows up as automatically
> selected without being useful in itself. This way the PWM_LPSS is sort
> of a common core that PWM_LPSS_PLATFORM and PWM_LPSS_PCI use.
> 
> An alternative that's commonly used for this would be to hide PWM_LPSS
> from users and keep the select within PWM_LPSS_PLATFORM and
> PWM_LPSS_PCI. That would be okay with me too.
> 
> Let me know if you have any objections to this change.


Didn't notice your message before.
Regarding to this one I think the way to hide PWM_LPSS from user would
be preferred, though I'm okay if it keeps visible.

In addition to compile error you get from Stephen, thanks for quick fix,
though I think we have to make PWM_LPSS dependent to X86 for now. I
don't believe we will have same IP on other architectures.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

