Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD220347BC4;
	Sat, 25 Jul 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784991911; cv=none; b=qLbHXJnOIsRBZOC9yO14Uy7SLBgISZMhFGDS4rwSL8GXYG8Q/z0bAMdxOx5wsXhYDSfD1KsZjOmHEsB+c+ieb02qIY+imAcNsAsvYVSbrG14dYcNKKy5Zqpfp2EqXmuaTx1d4bbi7R05dP8artC0/+TMapgm9rZnst8sqIRfcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784991911; c=relaxed/simple;
	bh=zHQpWeKFwbr91xNC7XmgCfvKSYQP2X44/Jersg3yt44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdJMxCgnUS6xb6DLmuWKbJgL7J5gxeIeiPWemVH7QllutKODW9y2HGQMZDlUIjJ/wGUrCiMyO69jvayKX+178pE5lMWlZxji/a5Rc2nIDQBrmAVEUCLW836W6Lp+2tgg5rq8i/MkysZHlmGLQwhO9xrcA56s/ND2oVpeLeNt8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP9r7Hh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP9r7Hh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C271F000E9;
	Sat, 25 Jul 2026 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784991909;
	bh=HqxZufIgqARr0p/d12QBLftHOAViCXmZM5RhdjJirEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RP9r7Hh0xtH3A100mu7CFFSdTkiTnqXgvIH7FEVf6jaOjkpq59T8ElL9CE9MqZlCB
	 ghjUjDZJFaV1EsSmbfUNFycbLyQQgjneuTJQSWP39jOUWMEjvUFarqwiN7T+amyjVf
	 eBPkBNPbjul6ReHpitLLQW6zMKzi3VreutKQk/DO+ovSc3IGsar255Hp7TVYnuyFZW
	 IEGSjJG9YffdJfN/7lOTUtE8+GOy/A2GrQ9ohGrBFesbCcXP5g7GVcMM5fNW4tf8xY
	 KiwWWlZrZrDKcPQKb5CZtlT0iwIsEVtqhEX+7P8+KBjlOo9TPXxlqPJbEGQIGr22Wo
	 MIaprzXQNk8/Q==
Date: Sat, 25 Jul 2026 17:05:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, daniel.lezcano@kernel.org, tglx@kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v13 1/5] dt-bindings: pwm: dwc: Document optional resets
 property
Message-ID: <20260725-spectacular-vigorous-sambar-5cc0bc@quoll>
References: <20260724084153.1473-1-dongxuyang@eswincomputing.com>
 <20260724084304.1531-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724084304.1531-1-dongxuyang@eswincomputing.com>

On Fri, Jul 24, 2026 at 04:43:04PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> The DesignWare PWM IP has two active-low reset inputs: presetn resets
> the register interface logic in the pclk (bus) domain, and
> timer_N_resetn resets the counter/timer logic in the timer_N_clk
> domain. The existing snps,dw-apb-timers-pwm2 binding does not
> describe either of these lines.
> 
> Add the resets property and describe the function of each reset to
> support future use of resets. Add the reset-names property to allow
> independent control of the two reset signals.
> 
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

