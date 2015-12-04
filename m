From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
Date: Fri, 04 Dec 2015 10:21:23 +0100
Message-ID: <2782017.y2Eu5VXXnv@wuerfel>
References: <1449206553-26133-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:58411 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbbLDJVg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2015 04:21:36 -0500
In-Reply-To: <1449206553-26133-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Friday 04 December 2015 07:22:33 Vladimir Zapolskiy wrote:
> LPC32xx SoC has two independent PWM controllers, they have different
> clock parents, clock gates and slightly different controls, each of
> these two PWM controllers has one output channel.
> 
> The change updates device tree binding documentation to reflect two PWM
> devices.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> 

The change looks reasonable, but I think you should clarify that this is
an incompatible change, and do it in the same patch as the corresponding
change to set 'npwms' to 1 in the driver.

	Arnd
