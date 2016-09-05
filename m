From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Mon, 5 Sep 2016 12:29:53 +0200
Message-ID: <20160905102953.GF31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-18-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
> We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> be more inline with the naming conventions of the subsystem.  Where
> we used to treat each line as a channel, the PWM convention is to
> describe them as devices.
>=20
> The second documentation adaption entails adding support for PWM
> capture devices.  A new clock is required as well as an IRQ line.
> We're also adding a new property similar to the one described
> above, but for capture channels.  Typically, there will be less
> capture channels than PWM-out, since all channels have the latter
> capability, but only some have capture support.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied with a reworded commit message as discussed elsewhere in this
thread. I've also applied this in front of all other patches because I
think of the DT bindings as specifications that drivers implement.

Thierry

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUkeAAoJEN0jrNd/PrOhL3YP+gIBeZMt4hJFpinWIk9YEa32
ICG16beoSwFGCy3GqR31/vvqTLg63R00QzOVV3VaDH1ShQbDYbqebjGkscoVAMDR
CbiX91wKeqd552qyoC/IRoKzVUNZaoYB64kUQjYl4UKsD73MDGI9X2HChmIakEaF
96C/mEVkLOHmOwHE3o98jK3OI1jHgoWoab8yZppQ0D4bxKqmIW05DxSc3kFK4Qd5
bX98IfONnjkPIU5nd4ah+Ns/UXpS5luBKrKMaGUXqbGqgTBeD45Y9Bm4zMKSLThS
6/wwVB3mG+YPjI4sCUI55pN6DSeuBDrgMJwlDKsAiSg9weV8WsYzHVzc3a99wXgC
sOEZVXtXfrb7LrSsqsb1H1TWoBLYDhNxC6xJgfD7n5Rxiq6MuUH4Q4uQ4a0KGrz4
6Y6hRfXv/LU7C5u97nJ02+IMsSMm7xHKzBNDm9vxQ9vNnCZNMiBDFQ40r3ex+TDs
d/aNOUKOHP9PhaQVDlZoCY/1vx20+n16F7w8Lo46YL1JVmlN2RyFCyzGK0TOwYoi
KSpVbfE5NRpuoffSMtQ8x6qGynZHtrXmVJ8EW/ZDiBkGGgtNhyo94iHoehoFKAMr
CJ3fbsGroT7cH7Ip16qu5PLRvXV9JSA2MhU8rq6pIXgHssCzqDoIgzgeouII1m5K
Yw70XPB0+xVHxQX9GVub
=GGS2
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
