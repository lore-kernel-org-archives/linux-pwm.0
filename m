From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/3] pwm: add pwm AO on meson gx
Date: Thu, 6 Jul 2017 11:17:43 +0200
Message-ID: <20170706091743.GP16144@ulmo.fritz.box>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
 <20170706065910.GJ16144@ulmo.fritz.box>
 <1499331740.15362.11.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36412 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdGFJRq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 05:17:46 -0400
Content-Disposition: inline
In-Reply-To: <1499331740.15362.11.camel@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Jeremy Kerr <jk@ozlabs.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 11:02:20AM +0200, Jerome Brunet wrote:
> On Thu, 2017-07-06 at 08:59 +0200, Thierry Reding wrote:
> > On Thu, Jun 08, 2017 at 02:24:13PM +0200, Jerome Brunet wrote:
> > > The pwms found in the AO domain of the meson gx family have different
> > > clock sources than the ones found in the EE domain. The AO pwms only
> > > have 2 connected clock input which are clk81 and the crytal.
> > >=20
> > > This patchset adds the necessary compatible and the clock data for it.
> > >=20
> > > Changes since v1: [0]
> > > * Correct clock source order for gxbb pwm ao. Documenation shows xtal=
 as
> > > =C2=A0 source #1 while it is actually source #0
> > > * Add patch 3 to fix pwm calculation. Issue while testing pwm with cl=
k81
> > > =C2=A0 as clock source.
> > >=20
> > > [0]:=C2=A0=C2=A0https://lkml.kernel.org/r/20170607133013.4766-1-jbrun=
et@baylibre.com
> > >=20
> > > Jerome Brunet (3):
> > > =C2=A0 dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
> > > =C2=A0 pwm: meson: add compatible for the gxbb ao pwms
> > > =C2=A0 pwm: meson: improve pwm calculation precision.
> > >=20
> > > =C2=A0.../devicetree/bindings/pwm/pwm-meson.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A04 +-
> > > =C2=A0drivers/pwm/pwm-meson.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 47 +++++++++++++++++
> > > -----
> > > =C2=A02 files changed, 41 insertions(+), 10 deletions(-)
> >=20
> > For some reason the Author field keeps getting set to:
> >=20
> > 	jbrunet <jbrunet@baylibre.com>
> >=20
> > It seems like the headers are correct, so maybe this is patchwork
> > messing things up?
>=20
> And it strikes again ... :(
> I already had the issue with https://patchwork.kernel.org a few month ago.
> I have contacted the kernel.org helpdesk about it and here is the explana=
tion:
>=20
> "Patchwork treats users and patch submitters slightly differently, so onc=
e your
> entry is created upon first patch submission, it sticks forever. I've adj=
usted
> your entry manually per your request."
>=20
> So my very first patch on the ML must have been malformed somehow.
>=20
> >=20
> > Anyway, I've applied the series and manually fixed up the Author field.
>=20
> Thanks a lot for this !=20
> Any idea who I may contact to get this "manual adjustment" done on https:=
//patch
> work.ozlabs.org/ ?

I /think/ Jeremy Kerr (To'ed) would be a good person to contact about
this.

Jeremy, anything you can do about this?

Thanks,
Thierry

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlleADYACgkQ3SOs138+
s6HVAxAAjblEyF4Kjv4FUEIzUf/75caQWWOV4NWm5AjR2mbEUox+mikJ5ebpvTFg
I/qH9knRNTpcx7Wx+F6V1UHYPreQ/E6cu2govT/Bl9NcfECEsdpXlhgiAFRRehf+
Ionf+1WtbidSHIDgrEVjahk2Wq3IXDjkCx87RHVBmoQM0dNrXUA0qXjeYny35MOi
7KCwnjuFN4Xy93R2sZxATsZPYv7RD4jbXnvcc9Y7IORWOFOZRHt4HZ4kpFPa2YOs
AgR/BFMxVF2/v9yhkGYd9GhHktuVKcgJHM25i/9RcDPS+RehwZ+f+3CqBq+IgiLP
2FjpXJX2JL94/Z6iWMWa97ba1l9mJmGvEqiJtG92F9Vwv9LKdOKEDYtSDihoUshj
1vxofyE/jJbF8EEzSWSqv4vM/J1LrAf9q+gowzE6jRq2ztcbaghh9THP3UFZ44zF
nBKbah10lF4fBpU2CXbtvD6yeBwEJJ1zb1dj8rcRlF0oLDClbCLbbywkDyqvxJab
+0qNQYZDtTM41o+27Q7wT8IcjGFs9xFMpgoVVj+wYT4RMllJLiZVSRuzuAiRqP0v
j48EXB5PHn5qlNlvWuHOn04+SC06X6b16uwflN+Z0mOpHFXJoSmmC2/pw46doLAY
r87kkBtNySzi0UX7m8HQd4v7Q9xrUbM49UbufJ2Ta8t71CHVL0g=
=TbsQ
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--
