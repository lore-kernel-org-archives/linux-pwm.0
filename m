From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
Date: Fri, 12 Jun 2015 12:25:30 +0200
Message-ID: <20150612102529.GH19400@ulmo.nvidia.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34241 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbFLK0L (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 06:26:11 -0400
Content-Disposition: inline
In-Reply-To: <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173.

The driver also claims compatibility with MT6595, so you should mention
that here as well. Also please be more verbose in the commit message.
You should mention things like how many channels the PWM has or typical
use-cases.

Thierry

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVerOZAAoJEN0jrNd/PrOh6wcP/jaTZsgetm8oNboheRoNnTni
3mjo0OwpdpGa8FS4lGWmMjkoeAlznmcUkL8HZPjEHC2RW/rm52OpNquBI6Jjpu/L
DLS+3w221liR1aFsKmT5FdH7p/cr0GjVe+NxMunyqh5kpNyROJKVozmKvQWoCS5v
EQeA4DJ/F8KQjyHWNVQPPU8nURhZ7LcGA70dPoQefBU0zuAPDvnd6o6Pb9FPfkm4
uiCZR7+9UMTusLDdFUaIpTn+OrTlhtm90W10vAd0qHvNXaQpiSJrUVL2D8ah/pTW
YTD2ovTEfaouxjAu9gWis3rDGwYMiiljtpJdzesIs5YK0HFWTtKq4ZeQpcW/Ma/W
Dx7eN8pGsh1u2rOrxuptHl5Mfn/BKzeft63ErU6OurZzVLcSU2vvvupnTAhrrWwo
uQGt6XRMo2s10/33BBPlGyJK4O2WE5eNRAdWyMS6cgoZtiUPhEZtva6Yk+KM8AMr
xyNc3P8SbtDofEA4xnjzH4CAHhoi8G62tnBr3Wbf8JQ/ragog23UfqAPdDCfavCV
N7ZcT5H49zWRHuzTMao7QdHiocJAn2YJPNH0gCMJojOe5CbpB6TJhMerrEp89Z5c
1i1rRVfg/pL+FCxTS/iXsdZGcxi4JZYqlF5NwDAehZvvDCaIMrk9AtxyYbThEyIF
4dZYsphUJiBuOTdPtE/u
=2npt
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
