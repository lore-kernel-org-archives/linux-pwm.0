From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/2] pwm: bcm2835: Support for polarity setting via DT
Date: Mon, 10 Jul 2017 09:56:06 -0700
Message-ID: <87pod8qli1.fsf@eliezer.anholt.net>
References: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com> <1499508838-20715-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:42960 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754021AbdGJQ4K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Jul 2017 12:56:10 -0400
In-Reply-To: <1499508838-20715-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-rpi-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This adds support for the third (optional) pwm cell to specify the
> polarity, which is needed by display backlights for example.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlljsacACgkQtdYpNtH8
nuhDLw//aK5O/fh5yOw6QwCfVAxsAfp2VuDBCMh05eRZwSG2rHwAWvcIdlzsoXde
FtpQEKRI0iMB/v04P2UG90CFSUZuMJ7Jw98+Pj0Kl5jFmtPnwFBKv+iSi9dwUu68
aWeh4vY5uFKatYHu9o8t1beMoq4aLK4kK7SovHTvJP0LTxteyC6Jzue/3J2b2Fxd
7HSN+MuJVlbRNCmZhgriSuLkO4jxkwYZ40JTbTXuK5dy4tNTrrtHVDrt1N1Z7RDz
i13PzwB6COFOsYjtBw/q6NfK8jHHfY6auGk8w0A5B/GnGndjqJ5vNi5xKugPcJYm
/W3UTjIheEBBDP9fMnta4RY7JxBuI0kxYINkwq8rR0/Mt/aqHhrJXsMUVhINexA7
mmDd4HWwFTcMFCsxaFX8L/zeq7h7OS5FyQIwHbMob+RidyHWXseY5oX7ZDVgKjB6
IfPYJMF2r7IfEOccRlfclCBf0iGzPSn73GvxFPspQdeq8MEw2SlmPKW3fBktdPXL
3gMfCF8WsBgYCZEUuo7qu09SM+IWoMAHr5OZfzcqsgpyLZEHSHGk5D9Gn4R4LFxs
w9DUmbjF56VBHZqKkss9N7p+WW4ab5zsf3pS9v+9wJGQE32phZLHqGG/Dz/4Pnfg
fQ73fnZXxgKGy/OgsUqFFbPHlkhgfVoZPxfaxOcT3732kYGj09I=
=pzNG
-----END PGP SIGNATURE-----
--=-=-=--
