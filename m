Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB51396B73;
	Tue, 23 Jun 2026 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199083; cv=none; b=FZPu9N3lV+gjog1hqHWOx/Y5x9VDrzNHcVPkbMv6/17MzeWA87NR47S1eNouL5yv3C5tSAQfZ7TFOPz9pBwOCXTfhnsuXrMOUO2tFtMGRJubOiRqHBHwvOBqSmJcrEsOPlu95CgDNIYQK0gFqHaTh0ojwTTmcVqSLpPD6KWSuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199083; c=relaxed/simple;
	bh=Adcu/jmWy2EKNebcW2rIDTnRpwRbDQ4O9MKnqeb1Ws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxY1BD5M2rtRbEa/sUtIV6FvjUExKs+VDONRt6IZ08zQmP3qKguweYcpNNFml2HUAaEBLtIcZkp/cAbteD7lBOa9k7x5ekw7wwbi3yJvjvRBsCRTPaMHO+gCkv7Uf/P+jqdXuAdjcwtfuxN+PRYmJH8rJg4rLqLjmXgmfG4qTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgBsWYEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgBsWYEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0434E1F000E9;
	Tue, 23 Jun 2026 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782199082;
	bh=9yyaKCZ453e+mnmNtFZpkZQX7TuIHAciPI5wonpdeho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bgBsWYEpY5R9Vpi7Vc9+fg8TMHR4/YkeuiNnVmSe4M+JKf07dYPFEjS2Yy5jC8dLp
	 BmUetl8ec3SX7JjN65XUlibS4/cWTyZIYsx9zuA5NOEt07hN6HKUIkt1Y9mTUggdRS
	 3cxlMx3dYa1g0kU2Br7a/xUQhVRgrVGWqa7+VdNani3BCTq/2Q7qAIK0Aefb5dplJG
	 6xSWWwF1Q8LbUWMc2XlHa+CgFyNiYPahx7VCjTsPiofZj9a+iZ1z/hZxnCVDEHN0lH
	 K3FlbT7lURv9motsEqaeiRHLZi4nsB0RoK8Vtc8ZRarkqg/Xuk34TvIcLSBuoXRM3b
	 FAaGhTi5JLlPQ==
Date: Tue, 23 Jun 2026 09:17:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Pal Singh <ajitpal.singh@st.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: st,pwm: convert to DT schema
Message-ID: <20260623-electric-adder-of-upgrade-8bdeb4@quoll>
References: <20260618-st-pwm-v2-1-c792d5795ce2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-st-pwm-v2-1-c792d5795ce2@gmail.com>

On Thu, Jun 18, 2026 at 12:42:07PM +0000, Charan Pedumuru wrote:
> +description:
> +  The STiH41x PWM controller supports both PWM output and input capture
> +  functionality. It provides multiple PWM output channels for generating
> +  variable duty-cycle waveforms, and multiple input capture channels for
> +  measuring external signal periods and pulse widths. PWM output channels
> +  and input capture channels are configured independently via
> +  st,pwm-num-chan and st,capture-num-chan respectively.
> +
> +allOf:
> +  - $ref: pwm.yaml#

Where is this compatible used?

Best regards,
Krzysztof

