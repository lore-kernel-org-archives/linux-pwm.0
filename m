From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv4 0/4] pwm: imx: support output polarity inversion
Date: Mon, 29 Sep 2014 12:58:42 +0200
Message-ID: <20140929105842.GG4958@pengutronix.de>
References: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
 <20140826092409.7dea5530@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53023 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbaI2K6u (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Sep 2014 06:58:50 -0400
Content-Disposition: inline
In-Reply-To: <20140826092409.7dea5530@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org

On Tue, Aug 26, 2014 at 09:24:09AM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Lothar Wa=DFmann wrote:
> > This patch series adds support for polarity inversion to the pwm-im=
x
> > driver. The patches have been tested on i.MX6, i.MX53 and with the
> > ti-ehrpwm.c driver.
> >=20
> > Changes wrt. v2:
> > - make the use of '#pwm-cells =3D <3>' optional, so that the change=
 does
> >   not break existing DT blobs as suggested by Arnd Bergmann and Sas=
cha
> >   Hauer.
> >=20
> > Changes wrt. v3:
> > - implemented the approach suggested by Sascha Hauer=20
> > - don't modify struct pwm_ops in the imx_pwm probe function
> >=20
> >=20
> Any further comments?

No, except this one:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
