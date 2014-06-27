From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Added possibility to use pwm_bl.c with percentage
 instead of levels
Date: Fri, 27 Jun 2014 09:09:03 +0200
Message-ID: <20140627070902.GA10703@ulmo>
References: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
 <20140627061231.GD9258@ulmo>
 <CAJKbBDDS1Dfpsv8C4W_2uBEgYpO2FmYyMHrZ9vAy_k_jTdV5MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:55031 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaF0HJH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Jun 2014 03:09:07 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so4650644wes.41
        for <linux-pwm@vger.kernel.org>; Fri, 27 Jun 2014 00:09:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJKbBDDS1Dfpsv8C4W_2uBEgYpO2FmYyMHrZ9vAy_k_jTdV5MA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2014 at 08:58:21AM +0200, Johannes Pointner wrote:
> I know what you mean because I have here for example a panel that only
> supports a duty cycle between 20 and 100 percent. But wouldn't I be a
> possibility to add optional nodes with minimal/maximal brightness or
> something like that?

We have something like that (lth_brightness) for non-DT and which was
supported in the first DT proposals. But again the equivalent using the
brightness-levels would be:

	brightness-levels =3D <0 20 21 ... 100>;

So the continuous range and low threshold are really just special cases
of what brightness-levels provides. Granted, it's somewhat tedious to
have to list ~100 values in a DT property like this, but I haven't
really heard any arguments why the range really needs to be that
fine-grained. Most of the devices that I've used have somewhere between
8 and 20 brightness levels. An exception to this are Android devices,
which do indeed seem to support truly continuous ranges.

Thierry

>=20
> Hannes
>=20
>=20
> 2014-06-27 8:12 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
>=20
> > On Fri, Jun 27, 2014 at 07:32:20AM +0200, Johannes Pointner wrote:
> > > Hello,
> > >
> > > I'm new working on the linux device drivers, so if I made something w=
rong
> > > please point me into the right direction.
> > >
> > > I'd like to use the pwm_bl driver for a sitara based terminal and for
> > this
> > > I would need the possibility to set the backlight within a percentage
> > > range. The following patch should add this possibility to the pwm_bl
> > > driver. The idea is to keep backward compatibility by moving the requ=
ired
> > > option brightness levels to optional. Therefore if there is no node w=
ith
> > > brightness levels the percentage levels are used.
> > >
> > > Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
> > > ---
> > >  .../bindings/video/backlight/
> > > pwm-backlight.txt     | 11 +++---
> > >  drivers/video/backlight/pwm_bl.c                   | 46
> > > ++++++++++++----------
> > >  2 files changed, 31 insertions(+), 26 deletions(-)
> >
> > Also adding the backlight maintainers on Cc.
> >
> > This has been discussed a few times before. In fact the original device
> > tree binding had support for a continuous range of levels but that was
> > rejected during review. The reason was, as far as I remember, that the
> > number of levels and the corresponding duty cycle values is something
> > that's usually determined at system design time. Often backlights can't
> > properly light the whole surface of the panel at every level.
> >
> > That said, there's always the possibility to fake this by adding a DT
> > property with a continuous range, such as this:
> >
> >         brightness-levels =3D <0 1 2 ... 100>;
> >
> > Thierry
> >

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrRiOAAoJEN0jrNd/PrOh4IgP/3O1Cgrc1Bz4d1z9aEl8IpRb
r3+5kG2iA7odSeq34u0PUp4tDMXUMmZWQxNfrBQEnY45caNVLDXp0+6eTg6otrUP
HC+C8iEjOGKgWOpU097GEfRzsDUFTziadSfxIEZBEbk5FsUDhKAi4/65RXswThh2
OhmoiCSq3stXfNUETdyTlMUtyR+vHiE/qIngH2qyclRfoKVAHYxJ28F1RWWZluX6
Gt0ozik9Eg+K3WjFncscPCKK6SMEVPjfsUu5lIi5XTx+3byTT6927iU1+WOAgcqc
m7fQ2J3u7SMqsflGmdzWh4cGmmxmLTfr1uSf/MtpZdWQuNOzLIcFO+JgYlIqDd+D
yaqwuY0iP10OKnfYS2o3AhY+pPbntJXL6nRPycBgENYtfQ8G3K5VFYb7NT14DvqG
CNCfGLP+dbvMvjFvwJ2TxyzrkKnSt4YKE/KHK3mf+yeEDa+0GgIZW6vuoYJlRvuN
1+599JKqlUzKAE76d37MJCGGVkzBOWXoSEqoIBtusn5wO4JmgpBxze1rVlzzBUcB
TZEoPpw3zhj7yjrA6r6F1Mwr3h/HUYXcBWHhG5yBYLQaw62vUUR8EuxSjtGdCPTI
FI8PYAClqzyY2TTolsfc8RS6eljzdjRWbKhYuQJ07gHsD7JEMg8N9pVfrqHoWv9z
kkwAkaxCh7qWhg8On/+l
=eRjg
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
