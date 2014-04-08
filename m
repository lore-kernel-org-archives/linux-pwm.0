From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Tue, 8 Apr 2014 07:02:59 +0200
Message-ID: <20140408070259.68923987@ipc1.ka-ro>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
	<20140402055350.GX17250@pengutronix.de>
	<20140407113652.GE26985@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:57792 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaDHFDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Apr 2014 01:03:13 -0400
In-Reply-To: <20140407113652.GE26985@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>

Hi,

Thierry Reding wrote:
> On Wed, Apr 02, 2014 at 07:53:50AM +0200, Sascha Hauer wrote:
> > On Fri, Mar 28, 2014 at 09:48:58AM +0100, Lothar Wa=C3=9Fmann wrote=
:
> [...]
> > > @@ -183,8 +173,11 @@ static void of_pwmchip_add(struct pwm_chip *=
chip)
> > >  		return;
> > > =20
> > >  	if (!chip->of_xlate) {
> > > -		chip->of_xlate =3D of_pwm_simple_xlate;
> > > -		chip->of_pwm_n_cells =3D 2;
> > > +		chip->of_xlate =3D of_pwm_xlate;
> > > +		if (chip->ops->set_polarity)
> > > +			chip->of_pwm_n_cells =3D 3;
> > > +		else
> > > +			chip->of_pwm_n_cells =3D 2;
> >=20
> > I think the presence of the set_polarity callback shouldn't influen=
ce
> > the number of cells the parser expects. As commented on 2/2 this do=
esn't
> > actually mean the device actually support polarity inversion.
>=20
> How so? A driver should only implement .set_polarity() if it supports
> changing the polarity.
>=20
> That said, I agree that the presence of .set_polarity() shouldn't
> determine the number of cells. You could have any number of other fla=
gs
> set via the third cell.
>=20
> > Also, polarity inversion could still be done in software for hardwa=
re
> > that doesn't support it.
>=20
> No. You cannot emulate polarity inversion in software.
>=20
Why not?

duty_ns =3D period_ns - duty_ns;


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
