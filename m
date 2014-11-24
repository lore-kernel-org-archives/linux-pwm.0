From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v4 2/4] DT: pwm: Add binding document for IMG PWM
 DAC
Date: Mon, 24 Nov 2014 11:14:51 +0100
Message-ID: <20141124101449.GC25912@ulmo.nvidia.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-3-git-send-email-Naidu.Tellapati@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54933 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaKXKO5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 05:14:57 -0500
Content-Disposition: inline
In-Reply-To: <1416621212-11701-3-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: naidu.tellapati@gmail.com
Cc: abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2014 at 07:23:30AM +0530, naidu.tellapati@gmail.com wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>=20
> Add binding document for IMG Pulse Width Modulator (PWM) DAC present on t=
he
> Pistachio SOC. The PWM DAC has four channels.
>=20
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> No changes from v3.
> ---
>  Documentation/devicetree/bindings/pwm/img-pwm.txt |   23 +++++++++++++++=
++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Document=
ation/devicetree/bindings/pwm/img-pwm.txt
> new file mode 100644
> index 0000000..d3828dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
> @@ -0,0 +1,23 @@
> +*Imagination Technologies PWM DAC driver
> +
> +Required properties:
> +  - compatible: Should be "img,pistachio-pwm"
> +  - reg: Should contain physical base address and length of pwm register=
s.
> +  - clocks: Must contain an entry for each entry in clock-names.
> +	See ../clock/clock-bindings.txt for details.
> +  - clock-names: input clock names.
> +	Required elements: "pwm" and "sys".

I think it'd be useful to explain at least what the "sys" clock is.
"pwm" I'd assume that it clocks the IP block, but what does "sys" do?

Thierry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUcwUZAAoJEN0jrNd/PrOh5TgP/2j9beYduFgaw6QnhiN/MmuJ
CPPupGZMjnUkmez21dKwFNryaoDWe0Wfn33eDEGG+03gJ0vF0fYjL8P6rveUtr8V
NmpnaCnEINCH329slBkN2/AIamSTqlMnfpetXZ1Gq9S3LrAi6HuTyhlb3ZRssFnc
O+Au98fOPGwubuikp9G6S0udTPNjTpZzeMVTybEBfxEMs96DjTfnrOapQBBJfMG0
R5Eh8+TtXeJxjCLNDqbKiFxxGjyH7Mr5LiZskrKoauzov5JUbWebYMkJlufN1bqH
7yMQtK8hklIvdCMYzgswCaSpMo7RzqEOmJAzT+BBxgkaAz2c5tXzcItSyGXdfMFk
Kg/I5KLXd97z7BV3NSWSUCOHBsldr8jxTTNIoBIvaMJHZo1knkG4lHW8xjGkSopP
cXNU/XI4D0DUma5wuDHrYehKMXPl9UMnW9Go+UFmoFR5f19EGqVpnz3ox2iylB0C
NBs0DWLcIG/lebX1Mfr3AMZPn5L33+cEGDlu3KeOpQqhEn1j0hDDOBiep+e7y4xg
+VeVi8JSaL+5roAkN/tMSvDVZTC6v6YWTg5gbziNdPVIqWnhWAO+RAkclLVj/nwC
Cu2N5knV+CdZdUjIcZZmx68Wr13ymgvEZm4YzFlOyZcATo6t1Djbu7+fTYUwL6Tf
uwTL/rLbIwHQfqGinWke
=jfc5
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
