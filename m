Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424937;
	b=nOkXSBaKpnlpLGGL5pCWEajBLPDNtkP7SUnAQ9rrMplJACSWpzMg2kxWrfivtWJGffFe
	 /SaWUjdngMKT4cvvaUAywJ0O49ar88SnrDS4kCQA2ocQyxv2l6UYhdLKnCohhZLMgui5U
	 aQOjMeXemHR4qnsFuk3oaMOmo+dmn73t/wFdeakcLO4wYhtldS92A9uFC5U7exKZEUw1g
	 glGYIF8tImRzKi3L51PhVp35vOfABk0Q2X73hTQEw/sUZ0mCCnGySJ0NLdOu5pIRkmP+S
	 Kh9PVWPUhZXhyPuyi9gIbXZp0YJNG1V7uuctzayrQ48S6o9VEazRpoYZSJAOGYxaplg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424937;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HCIl0ZnJ2Bwec3GAhVJ2XAZj1hRoXxBmMeJmz7Rzc5M=;
	b=MDrrKXyDD3Bbjc7b5P4J2uW1Hf1vaqrXovcDJinNYOLi6KxMOJgAidRIaXwofjug5Iu4
	 mIzox5KQECXz/044w6XlR4nXWrN6FdSkdHsOw24qGYAf1KFmwZ63/tIpNFHOoel5NDtKl
	 hCgPPv/3ArlMMhgYFQs1npztAcJvcRgggt5ohUal1iiU1HH8yT3zshgPOayt04RZHrNkA
	 j3EE2hDDJn50+n6tfb87GaOt7KOswo1AU5gTsZztGn+NrjSJMVDQYl7ewyt9wcM1KI3NP
	 UqLowfDZQ4/wajh8PxDUv9oviXIRpojM13Rfe4SVGWar23G/cyYWHUSX8IKiNFpvwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwvZSsHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EB606A31A;
	Mon, 23 Nov 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwvZSsHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256721F000C0;
	Mon, 23 Nov 2026 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424937;
	bh=HCIl0ZnJ2Bwec3GAhVJ2XAZj1hRoXxBmMeJmz7Rzc5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nwvZSsHgYx1vv8X6s6NsF6Oyvu9b9ARL0/7lhP0t5iTFD/TzZbAmihNBDWryR5I+c
	 wMRUbGejIrGo/ROTPB1lbA33y6gKlv1hgIEPJtJBFnpTQMZz5zFVpP6z3c3H4Ishck
	 FrGs9OFc9oss3DAlpMzOp/6DVojFb3JxgafkzK0oxy606G9flJlvDuaYOOWGEpyWPP
	 0FgUuUkW2Od01O3IK3PPZ70X7suDmQCHVeZ2jjQeZz+zBBKaSAurIEs/+HDXlKklbL
	 nYc8zSEx3gVMJoCs5BxKCSuN9jQ5LCXz3Q8FfeYo9o72oJA7VF36PXIcbzPuKbsZKn
	 xcQsNqzVKSWKA==
Date: Mon, 23 Nov 2026 10:08:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?RGF2w63DsA==?= Steinn Geirsson <david@dsg.is>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
	linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: hwmon: adt7475: Add
 #thermal-sensor-cells
Message-ID: <20261123-analytic-papaya-jackdaw-aeb5db@quoll>
References: <20261114004110.328050-1-david@dsg.is>
 <20261114004110.328050-2-david@dsg.is>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261114004110.328050-2-david@dsg.is>

On Sat, Nov 14, 2026 at 12:41:07AM +0000, Dav=C3=AD=C3=B0 Steinn Geirsson w=
rote:
> The ADT7473, ADT7475, ADT7476 and ADT7490 measure two remote
> temperatures and their own. Add the "#thermal-sensor-cells" property so
> that thermal zones can use these as sensors. Its single cell selects the
> temperature channel: 0 for Remote 1, 1 for Local and 2 for Remote 2.
>=20
> Signed-off-by: Dav=C3=AD=C3=B0 Steinn Geirsson <david@dsg.is>
> ---
> This patch was written with Claude Code, using the models Claude
> Opus 5.5 and Claude Fable 5.2. They wrote the code and the initial
> commit message draft, which I cleaned up. I directed the design,
> reviewed the result, compared against the datasheet as far as I
> could, and ran tests including on actual hardware.
>=20
>  .../devicetree/bindings/hwmon/adt7475.yaml       | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

