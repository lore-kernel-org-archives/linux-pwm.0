Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4983976A0;
	Tue,  8 Sep 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851699; cv=none; b=QAlo0dETmCLab8AWe7N9V5mNxJwse2dNllKpyi6UsXPeT8eZS3Z4TWpno1t62/LovWDIs8TrvSlInzs5AW6+LzgUEeebwXQV7Gf182TbLl7YnarbIi5lVbKN4EquFZdeyvnivy9VzB95PbAG8ufULOxqr8NkLvHghY2NSri21Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851699; c=relaxed/simple;
	bh=ArJeW2flTkb9rm1gkhAoy7DoxwAb/3A+bJJPz0B1eno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoVjnRnvYWbSB4I/UXlff7kSZDtjL1Dd+ag+SG8UJ9hc+l+F72R9a/AeJL+XllconwsWhekMRZjpyRx9sjXNMgLRVOKwuN0UwqSgpSDQCOLqbriodXR0DOKOqSRj+33ZcBz8153nzzWfHYQepb+vhsu+0vHeZG/h3CYZVAAAwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LuGOZcyy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LuGOZcyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788851695;
	bh=ArJeW2flTkb9rm1gkhAoy7DoxwAb/3A+bJJPz0B1eno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LuGOZcyyYxieMA3pMCJAyaJj4o8p1ih3RqpJ1LuoGQp+cy3nnBLkjNQS1Io4bo2wR
	 7628PQg3TYOICpTlTHfBOaYB1w8fXqkGR5OaZrC5DzS8+QmRSFAGrZ4AaDazBnz/MH
	 yDfEtCZQXdrz7V/e0cizk0yfoL74Lzjxm18VJ5nHQHyv4nWuXOHTTOLYgJQZte062R
	 TcaPBywqYnWCcqhCmBTW+72QziGLgPLBUGvFHAuUDVGp9WMlTMcBQakjgxUoxpO/Cc
	 LhaB0TPUUMpAzxPVPOLMXYnkHH0RIbtOefVzc3cwxjswOHnUvmhBz+lyhE1iEtR0uI
	 9P0fTU1CLhe8w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5070217E027D;
	Tue, 08 Sep 2026 09:14:55 +0200 (CEST)
Message-ID: <30806e9c-8d37-4f99-b9d6-a2819acaeb50@collabora.com>
Date: Tue, 8 Sep 2026 09:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: mtk-disp: Fix period readback
To: Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jitao Shi <jitao.shi@mediatek.com>
References: <20260827105738.8570-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260827105738.8570-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 12:57, Chen-Yu Tsai wrote:
> The period value stored in the register is the number of clock cycles - 1.
> 
> Account for the offset when calculating the period in nanoseconds. This
> fixes the discrepancy reported by the pwm core when CONFIG_PWM_DEBUG=1:
> 
>      mediatek-disp-pwm 1100e000.pwm: .apply is not idempotent
>      	(ena=1 pol=0 281500/499875) -> (ena=1 pol=0 281500/499750)
> 
> Calculation discrepancy in the driver was found by AI run by a colleague
> while debugging another PWM related issue. Check against SoC datasheet
> and fix done by the author.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

