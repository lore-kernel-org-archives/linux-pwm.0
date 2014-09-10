From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4] pwm: lpc32xx - Add a driver for the motor PWM
Date: Wed, 10 Sep 2014 17:51:36 +0200
Message-ID: <12709842.iga6ki5KTS@wuerfel>
References: <1410363822-22151-1-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53088 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaIJPv5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Sep 2014 11:51:57 -0400
In-Reply-To: <1410363822-22151-1-git-send-email-alban.bedel@avionic-design.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>

On Wednesday 10 September 2014 17:43:42 Alban Bedel wrote:
> +- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
> +  the cells format. The only third cell flag supported by this binding is
> +  PWM_POLARITY_INVERTED.

If you don't have multiple pwm outputs or programmable period, I would say it
should use #pwm-cells=<1> and only pass the polarity.

	Arnd
