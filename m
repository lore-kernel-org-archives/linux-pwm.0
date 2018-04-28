From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
Date: Sat, 28 Apr 2018 13:21:15 +0200
Message-ID: <72c263ef-09c3-a05f-3c16-1bc8df667d38@suse.de>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-3-git-send-email-wesley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524869998-2805-3-git-send-email-wesley@sifive.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wesley W. Terpstra" <wesley@sifive.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Am 28.04.2018 um 00:59 schrieb Wesley W. Terpstra:
> This adds a vendor prefix "sifive" for SiFive, Inc.
> We make chips.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Andreas Färber <afaerber@suse.de>

but please reorder the patches, so that the prefix definition comes
before its first use in the pwm binding.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
