Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477E390218
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619995; cv=none; b=JwsgtRPBPf41u8Fnrk9pnmlr+VYvznGVCtrDZCV7blrpsPhUdf1IQ1mcyJ3Lzf1QjjpvyaYBRHuQCZQGhawLsdsamDzmLogGTZosxmRZ7nFuM7gwxB7+OgFx/07EucdE0N9RzAVvYJKzihhw214blqdXQxhx8AW4RBgbfK/AaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619995; c=relaxed/simple;
	bh=+b7CFFHgZ618D+Uis2e9wFQoJJRfY/sRed2KpRC4bYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FaWHtibXL8H4Dw8S2DqL7u0rbekY9CbYS4c4B/X2FHXhkUiuI+zEewLSqOkwcUoR5jgikpCXKd+dEXwExltWlpWDu8SofLnDIRy4ibV/FeeU7bAao1o8L+6mNvkShAE0BeV/LJFyKErIWZ245mOgk5WP8w1PmsgsTK2EAS0U2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T9zLs2We; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T9zLs2We"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso160161a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 11:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619992; x=1791224792;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XGjdMwJsnua5C5JwBesKhZf4WJKUTjxVN8HV5NiB4F4=;
        b=PTgivrbP/XcBAqUzdv0WfTY18Ui2aiAnneyojxDEJcL+/T/dpRH5sen1KhjmpK0lRC
         cmR2m0Xucsodhis/O3WlqnoE74DAGc5EsLmR8d2bE8AZlzRH4Tv35r0LrxMsNEc+ktWB
         RAJSm3g52h6ocIN1xrjdSbsQ/p9jOt5ooXO6IV2XuOdZwePfzBmD/0pdndzHy06E5dW9
         o8PCquY8f9T883CmOirDQh3C+g9L0+7KzagOHPtd60+wFLhELFWb6KQtX4QHb8v/KrqU
         inWj9f8E2z23RvGkZNTa4iM0V77D/wMja4fIv6Ixr8t0nCxVqSpHh3T7iiA/Z0Dj2lOG
         vHGw==
X-Forwarded-Encrypted: i=1; AKwUvBzZwoWxc24KbT9bgWuQTCH8yKvbXzLxm/5lL2y4rqZSMdIcEwWQL0t6tdyE6LTzoSBsHWp8bFIM+cI=@vger.kernel.org
X-Gm-Message-State: AFuF++l4oNAo1nkwTH46bwFNMVkZ2BoIi/BVXSqlBYGTw+atALxnt8gq
	gzuF/n79+VtcY7L2R8qeMnmrwd4m6OW7afOwFnKJYFnKGTdOq33O1ABzWQk7L70rz0Ux4+XTs6/
	64KtegVa7ICSXDB7z4iSZssUYiTM6cS0bBBXkxHpIebma2aqapP7wZ2wcT9bSICbeLH6Kf/kcrS
	sAb76FaDgXeUdzSzkaALzzlEAHP7snx2hezgl1kIziUyIqJigJlR7Ffkwue5oXzWnzwHlRqv35m
	6L8O/r+yEYR5f4NQH6G
X-Gm-Gg: AYBFou33x8Nv2AzvtupCO5EIjpRp21/dA50iC49NT6dg4dZgTeU7K4BBFVTw2Hj9wGJ
	MK7Lr3HX+kOzsUyWSQHZFiOHWejjXA4UZNqs5lttwO068NbX/FHvhuUp7XvwRuo51JwjaOUaLDU
	f3DqDGUwFD4wxFe14ugEGScsUyhB47CRQO7df9emjHXdqLHbH+seR0YovgDQBUJM9cmUf4x9vwg
	9AzewGjtzTlYvh3G1ni8UKIz4dT4qPJyIEWrU7afM0lkJJVgs7NhcVesUJBztTe3px0JWpKY4/S
	lSS4Goo3efO23p/nRvhEyuBZsv6jXFW+qjQZCuHo1z0ZcS2br6H+4SVc+Jzqnzpfdmn2TkVv8j4
	syhmrSKSmSQr01AuGmkCKhSvP0SoQx/qZQ48ps2pIypixIS5KDwe0c7RwXLsW+jATjFX0dtLSYA
	grIhtBrJCWI8vZ9uadOTRPmJEh2PzqfOf87mAVD538
X-Received: by 2002:a05:6a20:7fa3:b0:3de:7701:d15b with SMTP id adf61e73a8af0-3de7701d778mr1278291637.49.1790619992167;
        Mon, 28 Sep 2026 11:26:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7902474b2sm6240166a12.1.2026.09.28.11.26.31
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:26:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34afa104860so79669eec.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790619990; x=1791224790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGjdMwJsnua5C5JwBesKhZf4WJKUTjxVN8HV5NiB4F4=;
        b=T9zLs2WeOZ0WTMzPllACcc/68+cOEaryRNpBXBD8LDZjb0ici6+6XxGXrC45BsOmDo
         NFX6yEBxOTSe9G9CqdTs1mT1qfT+/F2QKXKSJc+5iE7+hudl7r+b0B8rMc4w5lg73mzk
         mwXjwbF5DQNa9zqTy5X4qfMdlSo1QJG5bUlRQ=
X-Forwarded-Encrypted: i=1; AKwUvBzEGtpa1Z3Wge5lY0thknP5y996cOOB5Bg0V6v5yU2gF5C+Ty0c0ZXE7c+UMURHQQHLsYcFg4h2c9M=@vger.kernel.org
X-Received: by 2002:a05:7300:3081:b0:344:1bd9:1f0d with SMTP id 5a478bee46e88-3441bd92155mr11160570eec.21.1790619989859;
        Mon, 28 Sep 2026 11:26:29 -0700 (PDT)
X-Received: by 2002:a05:7300:3081:b0:344:1bd9:1f0d with SMTP id 5a478bee46e88-3441bd92155mr11160501eec.21.1790619989070;
        Mon, 28 Sep 2026 11:26:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c17074sm27663297eec.26.2026.09.28.11.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:26:28 -0700 (PDT)
Message-ID: <7c437a10-985b-402c-b3ac-cfa97c53d014@broadcom.com>
Date: Mon, 28 Sep 2026 11:26:26 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
 Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1790606188.git.andrea.porta@suse.com>
 <ad9bc35d7c30f7925fed4c6621ed0f67c39c3f09.1790606188.git.andrea.porta@suse.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <ad9bc35d7c30f7925fed4c6621ed0f67c39c3f09.1790606188.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/28/26 07:42, Andrea della Porta wrote:
> From: Stanimir Varbanov <svarbanov@suse.de>
> 
> The RP1 chipset used on the Raspberry Pi 5 features an integrated
> PWM controller to drive the cooling fan.
> 
> Add the corresponding DT node for this PWM controller.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Applied to devicetre-arm64/next, thanks!
-- 
Florian
