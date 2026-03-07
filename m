Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C172459C9;
	Sat,  7 Mar 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889782; cv=none; b=nMqrYJ1hhWZ5FLzk/8vJjs5MuUUY9lgCVI/36I78ftbE05+SmKxAfBeZt1tv/6c07e/3Ty4uti4+Lj7fxeIN8TAkCrizOpJTyAFDomNdnj0g+F2P69wPdBhgTLFJ9IwLfQXFbDa5OD5AyqErw3Dq6Zl1+AcQcgMczcylgpxbFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889782; c=relaxed/simple;
	bh=Am3wOHwBJuFJUS24NKFgMOG4t0Ms4PpeocOaaL3kLnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skeIdiaxQwV1OtPleUaUtBFu9vkKqmyECJdp5M75jRZf/48ePpEzssWrX89ZwjDIgFS8ovs0nOBq25R3SSZw/0un9El3evsq6qSORReAHuKNW9FlBBJzXDcHYJE/dzz7sutLwOn304sR9Pr7YkOGBciiFremGvBQpriFM1JpxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxYzgFpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxYzgFpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A3C19422;
	Sat,  7 Mar 2026 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889781;
	bh=Am3wOHwBJuFJUS24NKFgMOG4t0Ms4PpeocOaaL3kLnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxYzgFpkW7Ix0smLL4KrP79/t5wnxjK/sy9teoaTwtDbpWkhxws3rvP5xjInc8m4o
	 S8z5pGxENH/x0ZD7O759adTYjpSfydSfzR66IkhRwbtr3N3seUTprBNWp0X/TWE2UC
	 0HVeraGI3ThROmm0a+d2g/kVn1Ll9jLxbWz8Qf78Sl8Nlrn+nYVrEobjpDNtAKF88B
	 ALtpxnsihj1lIy4h86xmEYH4yPpzOJs8x/zKG5ynqBy1uU5MVzFUsEF8KkdNQyT+oM
	 sXuQ8fwn5OVxzwRSbp9syO6nWmPPdvAF56fJeBVepKGpWQUtzBDS5+OSVwUAXfQxBp
	 64FFHIW4TvSiQ==
Date: Sat, 7 Mar 2026 14:22:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260307-charming-shrewd-mantis-54bf9f@quoll>
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
 <20260306093058.2126-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306093058.2126-1-dongxuyang@eswincomputing.com>

On Fri, Mar 06, 2026 at 05:30:58PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add the optional resets property.

Why?

> 
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>

Best regards,
Krzysztof

