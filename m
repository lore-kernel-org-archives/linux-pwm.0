From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/6] pwm: bindings: add MT2712/MT7622 information
Date: Mon, 21 Aug 2017 09:51:24 +0200
Message-ID: <20170821075124.GN18996@ulmo>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-5-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498802721-32455-5-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: john@phrozen.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2017 at 02:05:19PM +0800, Zhi Mao wrote:
> add MT2712/MT7622 pwm information

Please avoid duplicating the subject in the description. You're not
adding any meaningful information. I've changed the commit to this:

--- >8 ---
dt-bindings: pwm: Add MT2712/MT7622 information

Enhance the MediaTek PWM binding with details about the IP found in the
MT2712 and MT7622 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
--- 8< ---

Applied to for-4.14/drivers, thanks.

Thierry

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmakPsACgkQ3SOs138+
s6GBkA//RbLmfKdP5DIbJs/jqCcpYORvAJsEYfdKUGFAV7C21pQOACbig7LlCGF+
U/jw1DTR3Z4B4z2k62xyKdN1jI5SlefOTYkvQo75L/MZRX4xCvQMRGTdVdGhaXGt
O5jaPjRtXT/8cBChyIv24830hVGHrOtClvfPLfQd9r2qrDjqhqNFLC3KtPXrXcL/
4w1OEZZQ/gOr7k/RlmrVLdJSAYoeN/QFttcx7tQDoF1aLiZ2VlO/hKcp9ZAz5oTJ
zCfo8mqd7SR7F6ByijDPE6U++CeC3sMHIRIbGztS4pHmEW+EIXkjBDSK1vDaeD4A
QFXVkTTVpMHWL+mBj2+GOu6L2iujzT8zQXkT4WsKdG1AFGi8d8YdN/s5okL6D4n/
vGbsU5ofiU+XnFIemBqU9oxv5Ni31U4bYEroF0uG0M4c7Rre31qQ0hq8bLg46hkM
F9oNj7uXHDr5Z39BXBE/fvhsbzEKBfb03BbqB7G2rpUX2lZhSs1OVsZld0UXmV3d
mpNt+F7dsLIACk2P2nKJxJNzzwkKi08WW9S0nZPRA87v4jSb2L6n1p51/HwEzig0
mHZgfQC22o8qXn20kIHFkZeoHhzu3LD2gL+jP45DZQijDn4FzdnO+/yLeTdLcvjq
gJ5EPqIDVmtDnOh4d0Q5yR7vlOXKV+JDZgglXyQ4fl7p/uQBHvo=
=+INn
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
