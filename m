Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863C26738B;
	Fri, 24 Jul 2026 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872453; cv=none; b=qWv99b8vQzlVLcp9XD32PUvKG0bHJw9HBs7EZrgPaGiF4lW44MpFh15ReFNzu+8/5OAi0On2WUIAxrnFHIrFc9o67c7Wo3TrVmkfNsOMnVUTHJyoVfl6ohGI4dGhA67n5hhEArp0gIKz9sZe/9qSivC3tdTCvhjDR2NwMDIqvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872453; c=relaxed/simple;
	bh=5uFKbjYLPGMnxopGejynFGIJwGOv+X1uFM1HEiJBLtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi40HLXNnEt8vHMK0WaN/rwqVVvkW2HL6xxzkATE6DDeV6AyCh42/f51ZeF8JuCps644fTSTc46mai7op2TFo1qKQ7ocSmWxZPi278mDTUiXYgyfT5ngbeflkapR27I/832oBYq9kyCfeRbodtv+jQgExxWesdZUm1IEn6K9YAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q89+jzy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q89+jzy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D5E1F000E9;
	Fri, 24 Jul 2026 05:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784872452;
	bh=/L46xMxoWACdqxzcmYoJRkVKy8W/y1heSaNO+vsvtbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q89+jzy6YEGNHY2YNQ9Q+P84ElahNmkv4LqNRTB7a9mPGYHyXwf27EncMZ9u+0fwf
	 Xw5z3fIPDwuAOZyT58NLKbL7EtMn911bnRLoRmO+CBCMYZWfkxGKkM+GnTc7YDqRbX
	 f3Ns4kavCKKCfSx5HjzS7aLm+c3DMMRux3IOGP4v639/icwlK0Lz8BxNAPKK7nOV11
	 f1znUNgvx20J2poCOhM/icOhwRpu01WafhC44/fhC6sTuxCkwmjytyMgq9e7PGwHo9
	 Cv7OwLt/3y5xaovIoUYr39ydMTLmTYWqa3+jCSrOgLzZrev3nxn7LXrSzjvt0x+G2i
	 +rqdizTAv51RA==
Date: Fri, 24 Jul 2026 07:54:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, daniel.lezcano@kernel.org, tglx@kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v12 4/4] dt-bindings: timer: dwc: Update resets property
 items
Message-ID: <20260724-ambrosial-groovy-anteater-c2b349@quoll>
References: <20260721120757.1134-1-dongxuyang@eswincomputing.com>
 <20260721120935.1359-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721120935.1359-1-dongxuyang@eswincomputing.com>

On Tue, Jul 21, 2026 at 08:09:35PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> The DesignWare DW_apb_timers IP has two active-low reset inputs:
> presetn resets the register interface logic in the pclk (bus) domain,
> and timer_N_resetn resets the counter/timer logic in the timer_N_clk
> domain. The existing snps,dw-apb-timer binding only describes one.
> 
> Update snps,dw-apb-timer binding to allow up to two reset lines,
> matching the hardware capabilities of the DesignWare IP family.
> 
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../devicetree/bindings/timer/snps,dw-apb-timer.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

