From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFCv2 endianess 0/4] Add Freescale FTM PWM driver.
Date: Fri, 6 Dec 2013 13:52:10 +0800
Message-ID: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:45080
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752651Ab3LFGnG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Dec 2013 01:43:06 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: r65073@freescale.com, thierry.reding@gmail.com, s.hauer@pengutronix.de, galak@codeaurora.org, grant.likely@linaro.org, matt.porter@linaro.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org

I'm sending the RFCv2 patch series about the FTM IP block registers
read and write endian issue, and there is no buffers or descriptors
involved.

For the FTM IP block, in Vybird VF610 Tower the LE mode is in use,
in LS-1 the BE mode is in use. And the CPU always operates in LE mode.

So now I must take care of all these two cases. In this patch series I
have implemented two functions fsl_pwm_readl() and fsl_pwm_writel() to
replace readl() and writel(). At the same time there should add one
"big-endian" property for dt node.

And this patch is based the V6 series.


