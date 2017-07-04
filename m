From: Paul Kocialkowski <contact@paulk.fr>
Subject: PWM backlight initial state assumptions, or how pwm_bl killed my
 (nyan) cat^W backlight support
Date: Tue, 04 Jul 2017 23:13:34 +0300
Message-ID: <1499199214.1347.8.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+RgIjT78bRCD9g4HcOD+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pwm@vger.kernel.org


--=-+RgIjT78bRCD9g4HcOD+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I try to maintain support for ARM CrOS (read, ChromeOS/ChromiumOS) devic=
es in
upstream Linux on my spare time, I try to test out rc and stable versions a=
s
often as time allows. I have been rolling out 4.12 since Monday and noticed=
 that
the backlight on my tegra124 nyan big stayed dark for this release.

Not very cool, although I'm not blaming anyone else than myself on this,
I should have just tested it and brought the issue up during the rc cycle.
Still, let's try to move forward.

After investigating, it appears that the pwm_bl driver is enforcing a polic=
y on
heavily relying on the backlight initial state
(pwm_backlight_initial_power_state). To make it short, if backlight wasn't
detected as already enabled by the bootloader, it's going to refuse to enab=
le it
during the whole lifetime of the driver.

This policy isn't exactly new (so I do realize that I'm a bit late to the
party), but it went one step further this cycle by adding a check on the PW=
M
state. This broke support for my nyan big, as the pwm driver does not check=
 for
the previous state at probe time and reports it as disabled initially.

One could say that the driver has to be fixed to report that state (and I a=
gree
it is a desirable thing to do), but I think it is a symptom of a broader is=
sue.

Basically, do we really want pwm_bl to behave this way? What is the rationa=
le
behind this decision, other than "because we can"? A strong argument agains=
t it
is that not all bootloaders have support for turning the backlight on (that=
 is
definitely not the case on the omap3 sniper and omap4 kc1 boards with upstr=
eam
U-Boot, that I introduced to mainline Linux).

Also, we can still expect the gpio/regulator/pwm drivers to be reset at pro=
be
time (and I also agree it's not necessarily a good thing, especially as far=
 as
backlight is concerned, but that's the reality and dropping backlight suppo=
rt in
those cases doesn't seem like an appropriate course of action). This will r=
esult
in pwm_bl assuming that backlight was not enabled by the bootloader and thu=
s
refuse to enable it at all times.

Comments and reactions are welcome, as I'd really like to find a sane way t=
o
resolve this problem.

Cheers!

--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-+RgIjT78bRCD9g4HcOD+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAllb9u4ACgkQhP3B6o/u
lQwQFw//VYWGK54bxbHx64W3TVdHVZnRWfu+2YKBREMyIeNQ+7PXDVJQKmakh4Fh
EsTezbs4cUYAD+uWEPk+xuHQHLWwCqmqq+Ntg+QGGQnVaTgZA9FC7cudmsccK8AM
Y5XeF68wP1W/OYPGu03dSWUSVfqMDCtevfaZyelCl9XhPt/yTJBmE8b7vAT6phhm
eyV4R8C8Ivq6hf34G61HlLSrUFBpH65vA2HNTZD9x/hIB/YQOFdiaX5GqGrd+fth
A3BcQrRRitTtQA8VwCLFxgGA4EHwIuPwKOX0IpriQ3FWjXJfMequGt2VeAlw+43q
1uctcVZMve/zScwnlRwQMon9dSBN0f4A4gxZ8kAHLfZh0glmECA9sIB33Na9DKFR
cY2hzb6G7ZWLaIgkCLVLpLd+T9sz/YQ5juPOScsOty4YE8FSCtG07CP7BK8nMyUQ
kNqbFXAIZKitgKCNFS/bd9Pz3nx5gycEt+Gv1nYpwdvtfod5E4M05dt0wAGfsgHA
Gq3NNS4cvmho0llo+oMskmejjCFHZjbe8Rx6HfWU4lKmyKzhA6KtPvyy1bOf5nW8
OEy3B5XEDRNsQOTX4MjtOR1232Rj6kMrlmcl4fSFsDxuZqMII/zhGeZAUYTCAI0H
YUfOA+R7Qp2mXsOp2OoRjQETpHDRFZX0XpWr4EbX6dhXyNKuomk=
=4N12
-----END PGP SIGNATURE-----

--=-+RgIjT78bRCD9g4HcOD+--
