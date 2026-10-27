Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126686;
	b=xx2nlMaxP7Zf/JIV0mONEQWrQ01JIBpfyn7hN2GWITaFerKCSjaYMuOu46vXyNdbSS8j
	 PghuBt6rTJEaVYq87YT40GkUol4cXIm3kjTeOIvDpSH/8NCxxDwSJ6mNc2JY+kFg8M27e
	 TmPgMixw5AI33Ojae1GCYp4eugpOXvBB+CU+8F0PEhmT24z3ivF52MpdQBy1v4j/K1nu3
	 ZvyJaVq2m+tYQQGnwbDZclVDWNCuF9nDViDcWBsZG9hHOqt/bPPYUocAUXHkXehFgrLNg
	 AOapEbxVwb1wSU6QncHMwEx0rMAYgznnQn6QTUagCLJX+45RkVDbHq7w6tefCLPRc0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126686;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b0Z48kj6aARfzbqYUqSNACr9+QiImd5QtvnvY0f4pjc=;
	b=xTywZyS0JsYV4DNp2+0hRU1qBnlfWTZ3BbyNStU7BI8gvt2I4p+09lVWrQOUnS4p8fpr
	 1uH3OU5r4qsj6V3v3bk6tYKqHUEPyHgN81XpFaA4IJ7GLyK2Zl+OruugXPGcNzIrjsPBj
	 2hjtXv5cRP6MzgT47SWq3Gt8vibFBxEBKm/gU+4zQaMnsHpD4Nu+olGehO8AG5Umi9Yoz
	 +37UIYnyT9ZrpCa4+/E5Vt8x6Myh5hrLWBGPjTiqu9zcaPB7HJut4C37U/czzoKkBW7v/
	 0Sl5UsCVWEKO4HL8ZA5VMgCUCjwfBqSGaU/3dvNWdqEdhRVMqQZWirUjK9rkWy4NKNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XolTE89y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F60606A31A;
	Tue, 27 Oct 2026 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XolTE89y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3972D1F01825;
	Tue, 27 Oct 2026 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126685;
	bh=b0Z48kj6aARfzbqYUqSNACr9+QiImd5QtvnvY0f4pjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XolTE89yw5LlraILMaRseAZok2G2W1EBWL5zLn3jBHgG3C4y6oOOqmtaWkVMdu/er
	 eDVWBgnpxuS0Bqx/y0cCgzbGvj4s4jMbchKcznIxOzhTNW5TA/NnaQMrDDopPUAcyn
	 fGFg+/ikaGINyIMiaum4BoNz+m5nXjsooUu+r+SBl1viHsRTfD62IoOzSC5KDnN1ER
	 f5esN4OaW5tZtC7aEPWv5NNAP0N3UaBR3qbQCbI/FXRHRMPqG0wz04z4wY9P/A/dMG
	 vdoSUs7wKhgHB0lxNbhgG+tc57Y9cFue7gdNQcY5JkDT0SpuHFY35Yz7MANZczu1/R
	 NUT4naoVWeqQw==
Date: Tue, 27 Oct 2026 19:44:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add the Ingenic X1600 PWM
 controller
Message-ID: <20261027-flying-oryx-of-climate-55f0ff@quoll>
References: <20261025191624.9219-1-olivier@mgcrea.io>
 <20261025191624.9219-2-olivier@mgcrea.io>
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
In-Reply-To: <20261025191624.9219-2-olivier@mgcrea.io>

On Sun, Oct 25, 2026 at 08:16:23PM +0100, Olivier Louvignes wrote:
> The X1600 has an eight-channel PWM controller of its own, separate from
> the TCU timers that drive the PWMs of earlier Ingenic SoCs
> (ingenic,tcu.yaml), so it gets a binding of its own.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/pwm/ingenic,x1600-pwm.yaml       | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

