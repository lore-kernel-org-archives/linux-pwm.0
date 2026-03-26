Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFD3B6C1E;
	Thu, 26 Mar 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514188; cv=none; b=P0d3i9Yf5nwldbsacu9wGcmlzUujVjUqfxIL5CygUvzLyp1eoa6L6r0U59JhtPddNCir/x+L4k7zGV2wYtItb745a2wJF+HHQ2sAlX1jgzYl4qjuz/b9CY7T7zQtVpISHgAyLSrmQ1qs71oP1WKEphbOWJw61IheL3gcUq8tHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514188; c=relaxed/simple;
	bh=1i0nNFABO9IcWj5T5hP3tWFtWMyMAwy/5TZSXO/JiaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH/3EUoOu11T21YfGjqdF/s2R6k6XyMGoOxGvsaHXfleIqBxz8/QWuYHOpXkvrpBpTNU6jBHsGjvW08lEjQ486dGRHEc1faBLT2TSfO1oVJzXHbyMc5cpF5V2dhMzAoJc1j6PKA8yNTyCrE3bqUiv8i5b5yaBm8ajk+5KddA3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikj6D374; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikj6D374"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E05C116C6;
	Thu, 26 Mar 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514187;
	bh=1i0nNFABO9IcWj5T5hP3tWFtWMyMAwy/5TZSXO/JiaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikj6D374i7Zlq4OlKHSmBYmXTNGzrFdmB8PEULWSxexofBNQla1nhLxPkkfiJuJDL
	 +CuPjajpXQa2Y0MLdrf1tNH2O0LLmNarCZ6/4H6GEF28aeS+N93PNPYlhBfbzhXHdj
	 ayHQrlE6gNSO/gd3SG08k4VqRzsgXinMTpfqofyE7Sj4N5I5O4DPM9BOAGfn7YppRb
	 dcdbpMUrs1pqyr9iwrHU0AV5E13nB4XcG7HSv7XP6kYXvWvYlREp7m2HQ6BBHqqOra
	 x63Q6oZudxgAghMXuJ+Su3shqQG+EN7JSEb49+qRn9MhgieHSlOITM807l2HGSJ6Ll
	 oDfTl1gA059FQ==
Date: Thu, 26 Mar 2026 09:36:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
Message-ID: <20260326-portable-muscular-monkey-a1c3ab@quoll>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>

On Wed, Mar 25, 2026 at 07:16:59PM +0900, Mikko Perttunen wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The PWM controller found on Tegra264 is largely compatible with the one
> on prior generations, but it comes with some extra features, hence a new
> compatible string is needed.

Same comments as before.

Best regards,
Krzysztof

