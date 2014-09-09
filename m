From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] pwm: lpc32xx - Add a driver for the motor PWM
Date: Tue, 09 Sep 2014 20:19:25 +0200
Message-ID: <79685201.RtYEqhYoTB@wuerfel>
References: <1410277361-26848-1-git-send-email-alban.bedel@avionic-design.de> <2942175.JkZcLDKfiR@wuerfel> <20140909180530.635ce6f7@avionic-0020>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54642 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaIISTd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Sep 2014 14:19:33 -0400
In-Reply-To: <20140909180530.635ce6f7@avionic-0020>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>

On Tuesday 09 September 2014 18:05:30 Alban Bedel wrote:
> 
> I'll add COMPILE_TEST, PWM is already there because this is in an if
> PWM block. However I'm not sure for the clk, the LPC32xx use its own
> implementation of the clk functions, what should I add in this case?

You can add a dependency on CLKDEV_LOOKUP, which is set by both LPC32xx
and by COMMON_CLK.

	Arnd
