From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Date: Mon, 9 Mar 2020 16:34:37 +0100
Message-ID: <20200309153437.lwc5uutytj7rvee2@pengutronix.de>
References: <20200309145558.16098-1-pbarker@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIPek (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 11:34:40 -0400
Content-Disposition: inline
In-Reply-To: <20200309145558.16098-1-pbarker@konsulko.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Barker <pbarker@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>

Hello,

while I like the result in general I'd be a bit more careful here. So
I'd split this into several steps:

  a) add
	#pwm-cells = <3>;
     to the soc.dtsi and undo this by adding
	#pwm-cells = <2>;
     to all machine.dts (that don't already have #pwm-cells = <3>)

  b) for each machine with explicit #pwm-cells = <2>; convert to ... =
     <3>;.

This has the advantage that after a) there are no changes to the .dtb
files which can be easily verified. And the patches in b) can be
individually reverted in case something machine specific breaks.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
