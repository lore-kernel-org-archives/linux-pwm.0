Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662846;
	b=pMXOapYQhMD35Ms2kE1T4BuuY95SlPcKU2+J1VFlGjsDmdNNXBZE8H8+nNtjEgFgirqc
	 KcEqTNJL6+Xpsq55e6ONKwFksxghuhtPCwpC0+ge7wGfL7yspunuExR4UQkh6/7NkzX1x
	 wadQSrqq+OTPQM1qupm9sChu4GVag6nPBpg5qfRf1l/yoHJFat1nNntyvUw+k+ANrxH9x
	 +svAOHnnIcG427JX/FMRIAzJ33rbaH3qjG9wymeewJAWXvGV+jrbrIfKH6PRdHr816gWp
	 k3FZzfKuzSBzBcppC2EHVgs3RMlZswW4aryTW2/DGILyc5xo2PAWB/VDWOyD2Z4RPTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662846;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1qS2gMjZPd1EHR4c4W7/tHtacPWAHBdpQDlgMSeIbDw=;
	b=of1Uq/xpVX+pHttnBykSl+NiYJaqyi//rgEsLOpIwAES0dn7AFYdKHjgj1yoFXuIbRlh
	 aLjEivf6+FCcYzIbVz9yDWZnur/y7xgiuJ5+Q7XnwaGFmKF7XjU7sVSpzq92Sg/DpKObj
	 el84vwo8jVu8Iv5n7Dskvm0rtsbtT3sc7OVzOClLt5LRZWpJ9v0MJw4bBkAU8WBVWdAbW
	 xKvecQrr0O8xGWsL3oAWLoB43r4HCLj0KvvXHN8oGrUhUVXS10rKAtcefnGtpwi4uQir3
	 JaJueZqdguNn2y/vjlVyDHkm2QcBCMZuanzWgZEmgGvB6Qry0MXB9Osoo5jzzXPqC4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyeEzegL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC08606A31A;
	Thu, 22 Oct 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyeEzegL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806231F000C1;
	Thu, 22 Oct 2026 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792662846;
	bh=1qS2gMjZPd1EHR4c4W7/tHtacPWAHBdpQDlgMSeIbDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZyeEzegL3GvU3cUq/WRwQuv7PgL2a9x2SHMzivz59oi+yVtXq1qnEmIq/gIAbC5lI
	 Rq6qQ5tR8BhYvwPRPXGva6JeEBJE2/mttXgk6AeC0KMsES6nujPVm77sjBcOjCmpC4
	 dFHHB2N3qrYDPmEkNwTXzdCaNLLzKxOL596XBlGwpp2C9NMn0wxclOwm6sYiWEB1pa
	 K3ulDky1UrP3v6e2uxvcQiyJYL52KuiTsojC84tuiHf3qKSdLt+g4D4/JlDQsJRmFb
	 Q+GJe2adCUjMYvH2uDLKAhmqus579Va2izTIDZQN4QHcDTSoZuFbHrWJ2reYniihHA
	 lAiG7cHgjhssQ==
Date: Thu, 22 Oct 2026 11:54:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: pwm: opencores: Add
 starfive,jhb100-pwm
Message-ID: <20261022-sincere-glossy-goshawk-00d1f5@quoll>
References: <20261019110855.52420-1-changhuang.liang@starfivetech.com>
 <20261019110855.52420-2-changhuang.liang@starfivetech.com>
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
In-Reply-To: <20261019110855.52420-2-changhuang.liang@starfivetech.com>

On Mon, Oct 19, 2026 at 04:08:54AM -0700, Changhuang Liang wrote:
> Add a new compatible string "starfive,jhb100-pwm" for the PWM
> controller found on the StarFive JHB100 SoC.
> 
> The StarFive JHB100 PWM is based on the OpenCores PWM v1 controller
> but with a modification: the polarity has been changed from inverted
> to normal. The generic opencores,pwm-v1 hardware only supports
> inverted polarity, so the JHB100 variant cannot reuse the
> "opencores,pwm-v1" fallback and must be described with a standalone
> compatible string.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../devicetree/bindings/pwm/opencores,pwm.yaml       | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

