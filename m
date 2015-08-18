From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 1/5] pwm: add the Berlin pwm controller driver
Date: Tue, 18 Aug 2015 13:04:53 +0100
Message-ID: <20150818120452.GP7557@n2100.arm.linux.org.uk>
References: <1439897888-10921-1-git-send-email-antoine.tenart@free-electrons.com>
 <1439897888-10921-2-git-send-email-antoine.tenart@free-electrons.com>
 <55D31CB7.9030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39111 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbHRMFF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Aug 2015 08:05:05 -0400
Content-Disposition: inline
In-Reply-To: <55D31CB7.9030504@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

On Tue, Aug 18, 2015 at 01:53:27PM +0200, Sebastian Hesselbarth wrote:
> On 08/18/2015 01:38 PM, Antoine Tenart wrote:
> >+	val = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> >+	val &= ~BERLIN_PWM_PRESCALE_MASK;
> >+	val |= prescale;
> >+	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> >+
> >+	berlin_pwm_writel(duty, pwm, pwm_dev->hwpwm, BERLIN_PWM_DUTY);
> >+	berlin_pwm_writel(period, pwm, pwm_dev->hwpwm, BERLIN_PWM_TCNT);
> 
> The reason why I usually tend to _not_ use _relaxed() in low-performance
> setup code is that you'll have to think about reordering issues when
> using _relaxed ones.

If that is your concern, then you should read Documentation/memory-barriers.txt,
specifically the section on "ACQUIRES VS I/O ACCESSES".  Using the non-
relaxed accessors doesn't save you in every circumstance.

> The question here is: Is it _guaranteed_ that above writel_relaxed()
> will be issued _before_ actually releasing the spin_lock?

There is no guarantee on all hardware that writel() will be seen by the
hardware before other accesses within a separate spinlocked region
using the same lock.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
