Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E833556B;
	Wed, 14 Oct 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970329; cv=none; b=ZhK18ZW8oO5elxzxejCW5ukzOeXgiSPH1bshfXf1hOb28pGLYiqzeUrqCTTznGHUzS83K+JfJeoJqFGA7RljlrwTsQWVSZmt1Kl3rs//slv0xGa/NChmKTlBzmxNkPgnkg4mbvTgYlnHLyhbfEvGpplK7/gECcuK9nafX9jMFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970329; c=relaxed/simple;
	bh=J3ZibQyOt8EOgISnWGqIE2j058wGdTalEs7Qvrrjuo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjhkCWas7WcmQe4M6tNUeqphb8I6Vgs0kcznxZ5AlSMMzPgs94b6aSZhurznaxDVybMmcAeKP66sdrM5/fmOLJKY201gGETbqsc+pzGNxBFor5DlWKWKcLIVBYOga4fC3SXxt6zlKkWCHHnLGOJWcvclOpfofdDWi/9GSCfpz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrngTVa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrngTVa1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 589351F000FF;
	Wed, 14 Oct 2026 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970327;
	bh=7k4L+XmcqaiR3rYth3e/iXoJ284HcXQrcyi4M9FtnVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LrngTVa1jUTKYUsoYGUOMDX3+DwPxtZlRrBhAywQRS3C37zmj7O2UnvVUCd03yEJM
	 VgbZp21hjpAmEC8cGNn4rTLy0bA3e36Kr8tkjL3ocu9F3hbOjLPoVS1X2zYde+w9u0
	 xVE/Ie1Ew8mpcG/AkMcVaEPuRGzfGlus4EErsDdbIgPy5ew//yHSL/7iI2RFj6q/Ct
	 zstX53fO+QP4r2hlVKtw/+g3ysfRR6NhWlN+e43F4ZWQCSepsHE3NXs7d2+kKkkr6w
	 egw5ULdatf7EB6pHcuYb+hvCXeA2syNyi2mQZL3OAXhxQ/v8fHNotkLWLOp7kFo2gE
	 CGsx+DYUPD4FA==
Date: Wed, 14 Oct 2026 11:32:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	George Moussalem <george.moussalem@outlook.com>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: add IPQ5210 binding
Message-ID: <as9L8IEDMXuAYd4G@monoceros>
References: <20261008-pwm-v1-1-0b8776398632@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vstc2aamyuvuzxl"
Content-Disposition: inline
In-Reply-To: <20261008-pwm-v1-1-0b8776398632@oss.qualcomm.com>


--5vstc2aamyuvuzxl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: add IPQ5210 binding
MIME-Version: 1.0

Hello,

On Thu, Oct 08, 2026 at 02:14:00PM +0530, Varadarajan Narayanan wrote:
> Add DT binding for the PWM block in Qualcomm IPQ5210 SoC with
> qcom,ipq6018-pwm as the fallback.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml =
b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> index f9f1f652e752..c6b9004dd30e 100644
> --- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> @@ -15,6 +15,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,ipq5018-pwm
> +              - qcom,ipq5210-pwm
>                - qcom,ipq5332-pwm
>                - qcom,ipq9574-pwm
>            - const: qcom,ipq6018-pwm

applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as merge window material.

Best regards
Uwe

--5vstc2aamyuvuzxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrPTBMACgkQj4D7WH0S
/k5qpwf/fYRYL3KOYtqsaTbKGMI1tnzLWBoRH7mNKKshjl7O8aGhSqyEk+8QZ6b2
t8VaFB9Wo4Al5ZCp+q/3MUnwvR93/E5e0J8TNlFkw7sdY0/AeATU3w26c4vDXQde
9cvZKItIV3wBQEsMPzciWh7APIQOWUjqSVgBw+HgR1w1p7tKbNc1kfrz3wYSbMjA
xlXR9ryFpWCEAaNttRpFFIVPNe4ZNVSJ2QdS3e4ZGSIgpLADvSzlAkJF8PMCMsaK
G78MfgR4qlKgmFq534xCvI0SUbqYPcwsGQprvwUIoiXjfGAtkOFuKPGeAR4yekfl
WCha/w3q1GUFE3B3fOS84Ks675jsOA==
=Y704
-----END PGP SIGNATURE-----

--5vstc2aamyuvuzxl--
