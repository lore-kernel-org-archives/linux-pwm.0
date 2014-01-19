From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PWM...
Date: Sun, 19 Jan 2014 20:08:24 +0100
Message-ID: <59642204.3UzJCDJHaS@wuerfel>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk> <20140119190324.GC28056@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51218 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaASTI3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jan 2014 14:08:29 -0500
In-Reply-To: <20140119190324.GC28056@quad.lixom.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, arm@kernel.org, devicetree@vger.kernel.org

On Sunday 19 January 2014 11:03:24 Olof Johansson wrote:
> > 
> > Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
> > be specified in the pwms declaration in pwmleds.  So that doesn't work.
> > There's no property to tell pwmleds that it should use inverted sense
> > either.
> 
> Adding a property for active-low to the pwm-leds binding would be
> easy, and backwards compatible. I'm surprised the original binding
> didn't specify it. The leds-pwm driver already seems to support it for
> C-configured instances.
> 
> I'm also surprised that the imx pwm driver even has a #pwm-cells of
> two, since the driver only supports one output. It'd be nice if they
> had allocated the extra cell for flags, but it's hard to change now,
> unless you do a new binding/compatible value and deprecate the old one.

Actually I think it's not that hard to change: The binding can specify
that either #pwm-cells=<2> or #pwm-cells=<3> is supported, and the
driver extended to handle both cases. This would maintain backwards
compatibility for old dtb files, though no forward compatibility for
new dtb files with old kernels.

	Arnd
