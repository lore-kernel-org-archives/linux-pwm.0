Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FA4A9D6C;
	Fri,  2 Oct 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962623; cv=none; b=QM8cdoQPQy1dwVHGeoLR+OOjoHGISJVzYnizPFBjT2yTxg3DYH3pFjAsRp1wVXb6WBpWHnfEJa9r7YzgASyuv1PmOUNDecZL2b8KWyNmsE7uj68Roh2++N+yS4/GhLiIcNp0Jl6AJGCDSgAHMDItRhrB8VPw5pY/cB/EByA1AAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962623; c=relaxed/simple;
	bh=5EhXe+B8UDhFkCc9zVohfqtslHIAEi0UP6KxmDs8iNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR2+GMNVP8rVifK3ny+V/+TAK0JBtxOevTNB9swH6sNvZaYlBSiqFaqzvnG0a6N14t6MYFOwJp7nj02Eyb61ZzCEr7EEv7wlg61xtp8SV2A3pTwBZY0/34A7JEr9CRkxK3IhZYGNhrWwxa6u0J85OchN45oip6dElhoVNOHKpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoV84CsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoV84CsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5461F000FF;
	Fri,  2 Oct 2026 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790962621;
	bh=T4gk1Rw6DphWhNHrFH0m9t3b7vjDTAP7CzaSldK9PR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VoV84CsG2LhnumK2mqpK+Axbsk6nPk81v3YjxaNc7zVr21jnwKTGyJRcWb8mstUJl
	 NM1gPC5ikSSlEZCQk3wzSDyob8llcikrn9N0Oto+9DUXnr2x+URnepEemCuLa1hfAt
	 521JGzoZvxsSNH1V1SkNB9mK0nhKdd+v6TXHsO5YpPnzQJKY+9DLCBgTKWoGkZNkww
	 KGir1fuZfHu8TQc/aMRu6max2QMT0sQHbMMXIP4GUsjm6mRTvS2HMi41SVcXzVfUP0
	 Nx5FFG9kthOu4BI2hBO4hatZ/l8Lpdd4768IR/cHR/RZBO84INg2+k2jYMlm0FDmio
	 M0tfhnBbh4Jzg==
From: Conor Dooley <conor@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [RESEND v22 0/3] Add OpenCores PTC PWM support
Date: Fri,  2 Oct 2026 18:35:42 +0100
Message-ID: <179096253376.1939568.1957466503835691407.b4-ty@microchip.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810030714.48100-1-hal.feng@starfivetech.com>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=600; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=En/co67eXIdMGpoDBdCz6bNLW3nZ0tD5RHoRgp8pjn4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDFn7X+d1TOd3nTFPrPHnh8Vs+WJpZ84sL7P3rC+6XfZU8 83+hNDojlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEZCvDP8MXC927ZGIcnnW0 7Hmx6/iOc/pHvqds4WxfNHFBi3rLtFMM/103JRk9TW4zD0g6mf+c3/RbllzAC9aiC1HZkQtNMjL l2QE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 10 Aug 2026 11:07:11 +0800, Hal Feng wrote:
> Add OpenCores PTC PWM driver which is used in StarFive
> JH7100/JH7110/JHB100 SoC.
> 
> I will maintain this pwm module in place of William.
> 
> Changes since v21:
> - Allow non-zero duty cycles shorter than one clock tick to round down to
>   zero.
> - Drop the .free() callback to preserve the PWM hardware state after
>   pwm_put().
> - Update the comment.
> 
> [...]

Applied to riscv-dt-for-next, because this is independent and has no actual
urgency without a driver.

[2/3] riscv: dts: starfive: Correct pwm nodes
      https://git.kernel.org/conor/c/2186ec5f59c2

Thanks,
Conor.
