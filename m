Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95B312803;
	Sun, 12 Apr 2026 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775985647; cv=none; b=V0qVFfqr0hZVJXFtUmQGToppMdpoKy6l6+i7PDXOmp5Opvw/n420hdywcRNsgHldic8Z+Cj2WrBhP6FJ6w4UkssuAOuVEZnywMHBXylKPOLdGX8sLd4VnoTToasBfuysZ5/qTYcEuTIK1/t5NYn99dXf08LZUYtYkIhlphhq30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775985647; c=relaxed/simple;
	bh=rczNStscr53iHBjcCqFVqCWDf/LgHdrfBQWMDLQbIgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suzHfMBUGhLN35HW0rM5WqTLhVV7YKyQIbd6CExLCur+eSQiFPdbDPvLZjkReAsqnKr01gk1D8mZZNm/rawLaIB4j0axeW5lrdaLVZvSo+mkt+oPNkJG6JOH1rxm+HIKfykd/izIPfN/dcWvUQrwCBdndiiYufMR1PJr2g25/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALCNqMc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALCNqMc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24EDC19424;
	Sun, 12 Apr 2026 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775985647;
	bh=rczNStscr53iHBjcCqFVqCWDf/LgHdrfBQWMDLQbIgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALCNqMc807cOnpuj/vzKIl/RhVfL4NOVch/USLcg39xaO1JZB2xJpSSAP3gRt5h1i
	 EKmsTD9+OoSB0DicvqKI5n3ge/ehwC7Hx2B+x5TZxCY9jquSaVVtFhD5kBldrAknOw
	 NEpKTA8lzq5FJbtojsus8omjX3B2rgMh4v9NL87m3MN1cT6/zR+oV5OxuN6Oc6ak9z
	 2fv7BG04zNvWXZKLLzb16hT/DZczh6akwCKo4IUTSEx6cKI8XNki449zaErQtQ5e+L
	 Zx19E+wjNEBJ6htte0HqCPwVU1Uf1yzWAoNyNtPVTH0PU89h6z7UoMcahbs0VdT2bb
	 61ozkiM0CZlkg==
Date: Sun, 12 Apr 2026 11:20:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM
 controller
Message-ID: <20260412-elite-mushroom-of-happiness-fade9c@quoll>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <6f0fa1a817b5af5040b652320daa7268297932a9.1775829499.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f0fa1a817b5af5040b652320daa7268297932a9.1775829499.git.andrea.porta@suse.com>

On Fri, Apr 10, 2026 at 04:09:57PM +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Add the devicetree binding documentation for the PWM
> controller found in the Raspberry Pi RP1 chipset.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

