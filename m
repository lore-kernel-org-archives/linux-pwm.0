Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969190;
	b=2Kjx7iFzIWgUwcg0TweOajfpkumUW51v8eGt9CebKKZVxwV25vFOwUezdLNIY7Fo9zg5
	 VrszUckspgVy69e6GUMidAOifIqtZbcLKMCymson3HHyjEI9uJrS/hQjm3Kr+zwF740Yb
	 ggw0bnjgBCh0fS0qZG+soCyaQ4UPg3xh1lXQt6ROtf/W8a96gzhx60ywQMAFv2+RdPRjU
	 PFJ0oqOIZr8W6QVHi5fXMTreL2+M0eo5QPsXlPkhuQNmD8MGcR1p7r9PDwCBKgR23OwxC
	 wtiKfOD1VH7HoWDweM2WS9KSIePtO/XeSJ3d+kdrR2Ckc56VN6otHx1isipnPI610kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BPdc3G7jz54Uqtjn7AC8nrE7lGpl51rsY51aLrfVh0c=;
	b=vK7CR8jj0FV152vNtnSxPTMAW5r7/jUbMCueEoo6g7tOe2uoCwIxz4Ctg4K0nQZff3Oa
	 vMuik71cTsZ4NamTEZqoS4JeFkV3BZ44EG2bBCAKBUk6i7GDLdwu2XnTuHWJGhzDND7Xo
	 a39UGU+VDjqAsldZIKKnNjhp/BZJZJK6BHtvMeAlP5tEV1AwNs3WZ6NloMznT1mrecyBZ
	 YYl5ecZ27z3YCujcVEWf0U1pS/d7N/JhlV1SubIeVQusnpI3KkKfS48IvEtaqnA46QhUN
	 Krbw0YVJDJ74eK+BFDQMs+Y92LdOV5jL4/gXmes+N/D0WB+MgInRE+CRAJqtVwz9+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfCNjwZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D9606A326;
	Fri,  6 Nov 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfCNjwZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFF01F0089F;
	Fri,  6 Nov 2026 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969190;
	bh=BPdc3G7jz54Uqtjn7AC8nrE7lGpl51rsY51aLrfVh0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QfCNjwZvG+CC3xe0eQ7y6UM6w726zb7ufYTmtI0p1Ftuu85DVYYfmSTmHBnmcWuph
	 Y9PK5Jvm8k3OS2FeKPm56HB66JXa4HaEHqwIdNZ3BmlSLCcMz0lJHOvDAlRZ2v3/ay
	 sXV/z8qIDvgNYf1DhjV3M26yY2Mf+CriYIIcS2FvcvbuRyhDyWW7AxmG6Lm0CfXEoj
	 Ld6aB6yq5Z3kl+NIjJ5NcA9Xvhmt5p3aoEhbqM7hfgE9kJ9D1f7gFhPUBlqh73y3gS
	 D+xoy3ZafBK3VqN1noxIZaktAn2p7Fqx2TO3cmzRwwvErOWtsZFvoNCXBQyqgA6fVr
	 hhG8crctKJ0Qg==
Date: Fri, 6 Nov 2026 13:46:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 6/9] dt-bindings: pinctrl: apple,pinctrl: Add t8142
 compatible
Message-ID: <20261106-undetectable-vicugna-of-advertising-6d048e@quoll>
References: <20261104-apple-m5-initial-devicetrees-v2-0-fd727a82d380@cyberchaos.dev>
 <20261104-apple-m5-initial-devicetrees-v2-6-fd727a82d380@cyberchaos.dev>
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
In-Reply-To: <20261104-apple-m5-initial-devicetrees-v2-6-fd727a82d380@cyberchaos.dev>

On Wed, Nov 04, 2026 at 06:24:19PM +0100, Yureka Lilian wrote:
> The pin controller on the Apple Silicon T8142 (M5) SoCs is compatible
> with t8140. Add "apple,t8142-pinctrl" as SoC specific compatible under
> "apple,t8140-pinctrl".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

