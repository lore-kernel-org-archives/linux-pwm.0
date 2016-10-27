From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM
 driver
Date: Thu, 27 Oct 2016 07:59:13 +0200
Message-ID: <20161027075913.3f473095@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <20161024173607.36bc2cb9@bbrezillon>
        <20161024232615.77d4ea28@jawa>
        <35a950b7ff431e0545bbb259ba69b483@agner.ch>
        <20161025090724.727c10bc@jawa>
        <CAOMZO5Bnfg43VY6tdsahCQ3PoVaL+wCzmPLCMTBK39FCHY9SpQ@mail.gmail.com>
        <CAOMZO5AS93=RhsDeJ99YV_01dbFAYidF4UY1hqgJh=AWEsqedw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/pqQnife51P5LtreIiRsY8SA"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:33851 "EHLO
        20.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbcJ0F7f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2016 01:59:35 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 22F3E1A165
        for <linux-pwm@vger.kernel.org>; Thu, 27 Oct 2016 07:59:33 +0200 (CEST)
In-Reply-To: <CAOMZO5AS93=RhsDeJ99YV_01dbFAYidF4UY1hqgJh=AWEsqedw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Sascha Hauer <kernel@pengutronix.de>

--Sig_/pqQnife51P5LtreIiRsY8SA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Oct 2016 15:09:03 -0200
Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Oct 25, 2016 at 3:08 PM, Fabio Estevam <festevam@gmail.com>
> wrote:
>=20
> >> the i.MX6q is not booting. Apparently I do need to wait for things
> >> to calm down.
> >
> > Does this commit help with the boot issue you observed?
>=20
> Sorry, missed to put the commit. Here it goes:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/a=
rch/arm/mach-imx/gpc.c?id=3Deef0b282bb586259d35548851cf6a4ce847bb804

I can confirm that the above patch fixed the problem.

My iMX6q board boots on 4.9.0-rc2

Thanks for support,

=C5=81ukasz Majewski

--Sig_/pqQnife51P5LtreIiRsY8SA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgRl7YACgkQf9/hG2YwgjFj1QCgz0kkPDMAkny79LtCi6YhGgiW
t6wAnRwgGPTmJPB7/akcsR+tk1yuDGZi
=AQlX
-----END PGP SIGNATURE-----

--Sig_/pqQnife51P5LtreIiRsY8SA--
