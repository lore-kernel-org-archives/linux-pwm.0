Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742C2D0C7A;
	Fri, 22 Aug 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890963; cv=none; b=HGvYeOzrinZCPpEGoYezHMHA3X0KIVSxubQA9vlsjxZz+UtlZ1drDOnJhepLp84jmHArYtihcw7Hi7fAE6iWRuthxI5tZH9rGOd41GVpI2fcWfs9r5S3e5zov7OeUSd8a/n1qydHcXjzVV9ezg+EfETxK00o7J0ngPoJgAGD33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890963; c=relaxed/simple;
	bh=ga2fSHPA+FVbHREAXCuAakBrZ3j4TWxkyRpChyDWGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT9k2NoP+UgZ8flm5fBaBVs0UYkei65DZv3XAF62xonnoTkRuSxeF1YxGk2lYk5mLLer/9X2PGxLOssZkUZynL3v/NCCDK6tE5vz7qyQFlJtsyhlhTUcODcvcg2kj/MklitPEmEVCofX2tzlYiFUrkeR+3N1oiX8mFcAQc2dqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kufVl37X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kufVl37X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86027C4CEED;
	Fri, 22 Aug 2025 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890962;
	bh=ga2fSHPA+FVbHREAXCuAakBrZ3j4TWxkyRpChyDWGAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kufVl37X3PaHaB4TpMfPcgVFz/B9uJPhlk2h5/5Wpaxtqa6voLF4HR3o4uc9tdXo5
	 bW1Ozhx29sxtgq4FUM/mW598GXxU6CEJFdu8rerjTxeErRpqVaEtRgL6Q5MBequdWP
	 3Qvucp+4Wu9bV3eAryenPvNF5pRJhjyyWaHIkBmrTAX0k5skYkZh0iSaNkj0eC3zfG
	 uQgf+ZbTRfH+CxUFSK3IH0f2leWiFfqD3cIar5Ru37tX1E/KJm+uVU9xrO1q+9Nqtl
	 t5KpGfyfpmKKhBYfzUL6uW9OC9XDJQIgkF3TAPpT2VxjSlVGgtkCiWBIHuYuZUBBww
	 kQjxlw3/DNkrQ==
Date: Fri, 22 Aug 2025 14:29:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: nxp,lpc1850-sct-pwm: Minor whitespace
 cleanup in example
Message-ID: <175589096111.178600.8095358311314259528.robh@kernel.org>
References: <20250821083110.46420-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821083110.46420-2-krzysztof.kozlowski@linaro.org>


On Thu, 21 Aug 2025 10:31:11 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

