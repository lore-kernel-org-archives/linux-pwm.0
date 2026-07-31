Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A03101C0;
	Fri, 31 Jul 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481030; cv=none; b=HwY0rBP2W/xCS8TMGUETkmf18in2UVzj4P3pnTWkRp6jGq4LYMVKCLkEU+3jE2L/9YoGyW5uTP5Y86FIHyJq8gpdmNh/CCQOrVM+nuiN98CivHSxTMBGJI5UlRTiiQoOvqbs0HhzQ0ay9NilZTkvS/gc7DTlfVmWmU28gHd+T+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481030; c=relaxed/simple;
	bh=VADn+92ixpFyu15QPt4dsSFl/HBjrYkdd84BPy3oo9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxhGtPOIagQDk03zRgGyTqNNQDcVjAVTQodd/1f/kCsHKZs2ggb6ovUyM4KeDNFtctCczt1vNJk/T3BmNpb1m2/do4X27XtBQgwRSH95TblYjAY2jDCxhrcCAJlyunJawzEIpV4k2TbfKdhXNHDrVK1NQ61mK2rkZoRbTmae3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf+ikemv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf+ikemv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979061F000E9;
	Fri, 31 Jul 2026 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481029;
	bh=rTR4Tw7AquFIFAqLaj/yYC+yG2NUbQZyazIKeFZT3Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pf+ikemvejkUNjJZ/9aQVRbsAinZZKrQRd+AMvRNLCzHi5SylD/EIX/44qnfy+R5v
	 snrblLd6iOv5cD3qHxWN9FBoiIUuTHK+oKEyAfkUBYsBD/bdOx34W1NIAMVcU51YZl
	 ek+HnlKLa4dZOpSVJatUAmfdegUTyPG90iazrwtdbIrOTuylVOu0fG0S5O8Fh5+8Rm
	 CQMd9MMqFfG0DCsF4EQMJ8JGreCwzyC5tIZ+PJnZDginmiuqbkIKR7YecOVFW/2gQh
	 jl+BRS3B4ftMGwvzT9SLIibs5GWr70VqOV3fXTHaAylTNjno9CmKtxTmwKygeJpLln
	 Q8xrUB1u/2sqw==
Date: Fri, 31 Jul 2026 08:57:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, daniel.lezcano@kernel.org, tglx@kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v14 2/5] dt-bindings: pwm: dwc: Add eswin compatible
Message-ID: <20260731-utopian-fair-mouse-cce8b1@quoll>
References: <20260730111425.1680-1-dongxuyang@eswincomputing.com>
 <20260730111534.1834-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730111534.1834-1-dongxuyang@eswincomputing.com>

On Thu, Jul 30, 2026 at 07:15:34PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> EIC7700 integrates the DesignWare PWM IP described by the generic
> snps,dw-apb-timers-pwm2 binding. On this SoC, the presetn and
> timer_N_resetn inputs are physically tied together to a single reset
> line, so exactly one reset is both required and sufficient, unlike
> the generic binding where up to two independent lines are optional.
> 
> Add the eswin,eic7700-pwm compatible string and constrain its resets
> property to exactly one entry.
> 
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 40 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

