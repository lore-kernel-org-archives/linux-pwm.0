From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
Date: Thu, 11 Jan 2018 13:47:01 +0100
Message-ID: <20180111124701.g52kjm3hozn72je5@flea.lan>
References: <20180111113323.GA21976@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="afmtqalau3vau4gw"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51873 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933929AbeAKMrN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jan 2018 07:47:13 -0500
Content-Disposition: inline
In-Reply-To: <20180111113323.GA21976@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--afmtqalau3vau4gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 11, 2018 at 07:33:23PM +0800, hao_zhang wrote:
> This patch add pwm pins for r40.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

You should order your patches differently. We try to be as bisectable
as possible, and if we just apply this patch the DT will not compile
anymore.

Your patch 4 should come before this one.

Your commit title and log doesn't seem to match the content of the
patch either.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--afmtqalau3vau4gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpXXMQACgkQ0rTAlCFN
r3RdPg/9GgeoLaIoDIBJphmGKsDMKNT5pFEVCLzjp00U/vK/m6wK1azJ5IpBufL8
8ttXD57otKlBSre+Tvn/P8ClKhMnG75es5bJXZvzKnWHWrw18ZLr3o/HsdOioxXg
sNOXMiK0rD2DD0LLZDTGmNRq11eXOrSO1z3OcpKEOOYHpEj6MIuQBVYQflH6CRi9
Pf5vYfsMcSvxGxx2v7UoK4SOCANOwq4besxjqU1y/VDO/yFSQVWGCqhZeqV98mf7
HW+QAK6UC6jXjicJF2G2BJJbjIjcHLxzpuohBi7kCjBJVXxpWU5izTHmRvwBpIga
Fxqnx/MnhyvY/t68B31AXkRdmXz+dbSdRGfuCvvWe/TxbHLCKW5zbbJesdFrnq83
Lvw55ofLcKCPkazoRCurLWZyq3xbEH7WYkN+ls99W5vZoHR+Ou5pDijH1mQKo+Bh
2zGEBNMLHrWEnGkKzOKlUX1zPeyzJdPhQxfO3wNIonUDfmHDdQzBUbkifA0XKT/G
5v5oNM6X/xK143HmskGzvtm3dEWzo78aRrZ7us3SEw1PBYNAGmELGMBHCwAl40aA
dlM54KeS2/wi5nFYx0FttcX4jUXf6RoonwGkj4Rvitgr5+QOGW8ei+qmvpqJZ6Gh
iV8rfl3unuJ/T986xlBIZNMh245R8rb/ywjotyaiJHCIuHuMtNg=
=ioV3
-----END PGP SIGNATURE-----

--afmtqalau3vau4gw--
