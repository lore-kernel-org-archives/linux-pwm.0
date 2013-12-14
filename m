From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Sat, 14 Dec 2013 14:05:57 +0100
Message-ID: <1611879.darQQ1Xxis@flatron>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl> <BLU0-SMTP4320E405FB7D782DEAD759ADDC0@phx.gbl> <20131214124408.GG17467@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:47390 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab3LNNGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Dec 2013 08:06:05 -0500
In-Reply-To: <20131214124408.GG17467@mithrandir>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: randy <lxr1234@hotmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi Thierry, Ayaka,

On Saturday 14 of December 2013 13:44:09 Thierry Reding wrote:
> On Thu, Dec 12, 2013 at 10:27:04PM +0800, randy wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >=20
> > =E4=BA=8E 2013=E5=B9=B412=E6=9C=8812=E6=97=A5 20:22, Thierry Reding=
 =E5=86=99=E9=81=93:
> > > On Mon, Dec 09, 2013 at 09:06:37PM +0800, randy wrote:
> > >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> > >>=20
> > >> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8809=E6=97=A5 19:55, Thierry Red=
ing =E5=86=99=E9=81=93:
> > >>> On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote: [...]
> > >>>> Actually, I don't know whether the pwm works or not. In
> > >>>> dmesg, I saw: [  853.690000] samsung-pwm 139d0000.pwm: tried
> > >>>> to request PWM channel 0 without output [  876.930000]
> > >>>> samsung-pwm 139d0000.pwm: tried to request PWM channel 0
> > >>>> without output [ 879.615000] samsung-pwm 139d0000.pwm: tried
> > >>>> to request PWM channel 1 without output
> > >>>>=20
> > >>>> in my dts, I only add =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> > >>>> pwm@139D0000 { status =3D "okay";
> > >> I added samsung,pwm-outputs =3D <0>;
> > >>>> }; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D is it enough to make pwm
> > >>>>  work, if the driver in kernel has been correct.
> > >>>=20
> > >>> It seems like you're missing the samsung,pwm-outputs property
> > >>> (see Documentation/devicetree/bindings/pwm/pwm-samsung.txt).
> > >>>=20
> > >>> Thierry
> > >>=20
> > >> Well I have make it output to channel 0 now. But it doesn't work
> > >> with the config below. As it is a buzzer, I change your config.=20
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D r=
oot@mifu:~# cat
> > >> /sys/class/pwm/pwmchip0/pwm0/enable
> > >>=20
> > >> 1 root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/period 1000000=20
> > >> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle 500000=20
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 I have used a
> > >> function generator with Vpp=3D2.2, it works.
> > >=20
> > > Are you sure the function generator runs at the same frequency? D=
o
> > > you
> > Yes, I am sure.
> > > have the possibility to check the PWM output with a scope to see =
if
> > > it outputs anything?
> > I have used a oscillograph to capture, nothing(althought it show so=
me
> > waves, but it is nosie single captured by autoset). I have a scope =
but
> > I don't think there is any different.
> > >=20
> > > Thierry
> > Ayaka
> > Thank you
>=20
> I don't know what else you could try, so I'm Cc'ing a couple of peopl=
e
> who have worked with this driver before, perhaps they can help resolv=
e
> this.

I suspect invalid hardware configuration here.

Ayaka, could you post your board dts file with PWM enabled?

Btw. For topics related to Samsung's platforms, it's good to always CC
linux-samsung-soc ML.

Best regards,
Tomasz

