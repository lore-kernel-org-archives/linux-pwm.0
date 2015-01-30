From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 10:18:34 +0100
Message-ID: <20150130091832.GA16744@ulmo>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com>
 <54BE3369.9000802@imgtec.com>
 <54CA6089.50505@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54CA6089.50505@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com
List-Id: linux-pwm@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:32:09PM -0300, Ezequiel Garcia wrote:
> On 01/20/2015 07:52 AM, Ezequiel Garcia wrote:
> >=20
> >=20
> > On 01/09/2015 02:54 PM, Ezequiel Garcia wrote:
> >> A new round for the IMG PWM driver.
> >>
> >> The IMG PWM controller is muxed with a PDM controller, through a shared
> >> so-called periph register bit, which sets the output as PWM or PDM.
> >> Because this register is not part of the pin controller block, but rat=
her
> >> PWM/PDM specific, and because the register is also used to set the PDM=
 value,
> >> it is simpler to use a regmap-based syscon to deal with it.
> >>
> >> This time, I'm removing the PDM driver from the submission and submitt=
ing the PWM
> >> alone. The PDM was written as a misc driver, but had some design issue=
s, so for
> >> now I'm proposing to merge the PWM only.
> >>
> >> The series is based on v3.19-rc3. If at all possible I'd like to see t=
his merged
> >> for v3.20.
> >>
> >=20
> > Thierry,
> >=20
> > Any comments on this? Any chance we merge it in time for v3.20?
> > It's -rc5 already and I've started to worry.
> >=20
>=20
> Thierry,
>=20
> I'm very sorry to be so bothering, but I got no news from you and it's
> -rc6 already. I'd say I'll resend this series to Andrew Morton, hoping
> we can merge this for v3.20.
>=20
> Please let me know if you'll be able to pick this.

I can pick it up if you make up your mind about the license. The header
comment says GPL v2 or later, but MODULE_LICENSE has "GPL v2", which
does not include the "or later" part.

Also you're making it especially difficult to build-test by not
providing even the basic bits of your SoC support first. All even
linux-next seems to have for the Pistachio SoC is the addition of a
compatible string to the dw-mmc driver.

I'll take the PWM driver, but I'll assume that you'll eventually have
more pieces available, in which case I'd appreciate a note so I can
update my build scripts.

Thierry

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy0xoAAoJEN0jrNd/PrOhdzoP/iosFdE7SURQFvDGWxobalW6
42R7DJoSETupb3iPxqOoEj3kNB64jMTzzbbmW70i8TqCdNlLIqHvVZsVD72pKLvW
0KP2bdX2jLDYd2RJNRdsHsJ5elFCHGDnQ+/lABobGTPatCirmMUasoVCcMvj9Z6s
UICKi+Y9kalbj5DDaqIU1RcTpqxAlAWSeRSTd8uS+twhxYjhNkw6S4PcCBf3+tDn
nCK0w7yO43hi5qoGaecfrb0TyYE37MqTGfxinHH8203s/uckfR6sRtwnMKNLcnmQ
L3Q89nmrG4rPmeZ1siwILqmPArUBwn6LfEc1Fhj9KSoZjNCknQtG1xPXWTxjKiry
zhU/Q9GFiY+KqTV24hqjCsYAOKAxZto9hp1Gqa+HECTfWJ8Y/aiRIsZB3qC+7372
pPeHt11LTQ+SyJz98I5cUoIJFuxquCNlxkY0lQsdmQA+3iGC0kexOY0oPHOaO8Zk
TfbUU0drpPR1Aww2d1v3ENWWTIDSyCIEqx+3hMiVW3Dt/Fkbd/ujdN34G7PXhorT
hbWFTYTTShnETHB06y28OmGJjvO4nCGH3r6c0lbegGzCqyyqaZ6xANQOJBBJ4zWv
sUeNbCrbcQSZVrH/fINtaioibEiJxHJ113VJgkX7BmtEXFthjQLzXKQOUHSj+mcP
bPS2jP5mhoH0Rzm/h7Mg
=sI1E
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
