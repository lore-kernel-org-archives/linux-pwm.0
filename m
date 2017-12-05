From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
Date: Tue, 5 Dec 2017 09:27:42 +0100
Message-ID: <20171205082742.GA7174@ulmo>
References: <1496397921-1713-1-git-send-email-gottfried.haider@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36009 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdLEI1q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 03:27:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id v105so20012191wrc.3
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 00:27:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1496397921-1713-1-git-send-email-gottfried.haider@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gottfried Haider <gottfried.haider@gmail.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 10:05:21AM +0000, Gottfried Haider wrote:
> Notifications for devices without bus or class set get dropped by
> dev_uevent_filter. Adding the class to the exported child matches
> what the gpio subsystem is doing.
>=20
> With this change exporting a channel triggers a udev event, which
> gives userspace a chance to fixup permissions and makes it possible
> for non-root users to make use of the pwm subsystem.
>=20
> Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: H Hartley Sweeten <hsweeten@visionengravers.com>
> CC: linux-pwm@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-rpi-kernel@lists.infradead.org
> ---
>  drivers/pwm/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the long delay, applied to for-next now.

Thanks,
Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomWHwACgkQ3SOs138+
s6H7KhAAiCiKFsmYqcDdh6SUJOjqbPXJosGCIciXbjDA/SWfvEx9cphVUsISToGf
QvBwrD+0inpdc+EQB+X2W7ROu6xkbY1PlGmiLy06+XROIuoxgkUjMmtfyqLwtDHM
nzzgu2lxfFQoAZaHmcXYO0cSRmGCEmlJ9HInh1eGs7Yu5YXNvgS1feFd2ay5A4GG
EEM2DPxJ04jlsmywEAQKQA2njaAL/vUIVMzEYg1zlGODX3KfOTuSJJqDXcWZvDab
u9d3E0m49MXqGg9cEHOANt+MGNZHz5fGkuKfZdz/ymnBzKDYBHf8honuHbALUHEZ
g2e/AjUk9FvSFeSbX+n+DQpRhMzVyKncuBGYzsZqX6cRtOG0y93e+wETSMNssQFG
09dYoKoUHPe/pEcIOeQyT1aOPja4zoRS9Li8K/mM0Bu+lv6kUiwDBrLi6T7VdPYC
jqtvlc9Mo1iDiJ8E3xMR9+P2EJw6sEXoBenKsSEts5joLTeXgnOAPc+j9zvKddgH
VZoKGxbtWuXWwTqdhDmeE0IOBcpkgXcrrHeU6C8JKvuqfn3hFRf5FRQTDtl0Y+Rf
Pk0hJ8VWnGR9oBC3vdsFR6DeNa0ACybvKDDL79rPu/CXTHRvbqlCyscFobTMfFmw
54uPxP5jfbfbmiJKfeaXqavaK0khRvSUOFfrro1gbR+XmzEsPMU=
=z6pB
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
