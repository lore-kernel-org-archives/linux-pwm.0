Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013076.outbound.protection.outlook.com [52.103.35.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8A393DD3;
	Mon,  7 Sep 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808049; cv=fail; b=C/flVT/vd2AA48l2FqM6q/IvKKFgNouFnSMZh9Gwhgt+eEZakCqtlDpQtrXRjM7GN3yw6VTs8aVpg/eocXiPosYsuxin35Mfxkqt4WmgOnv6RCGGZWYham5tcUl6Hrv8iQD0/Eh121VQu37al0EnOAQcoJ7a6SEChcRwSIf0M0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808049; c=relaxed/simple;
	bh=3bueHxKUPyqBK21ioWv5Go1P/vM8RBpQy7l1OHV5jAA=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mX93fB1M4dMyEfCoE4cz49R2x66lz+wxK0dEHXLH+gmPPGgV4J8KePNpecuHSq+IjXsXccgJliOj4DMQqG+Z8zo8xIRt+vMwjhxJlbesE5zDby/wspLRgTFkMTXhmwDkxLTVWhkC3wnPY1Dda5XLqYOmGyCxkUu5eOT5CAhK9T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fUBjkz25; arc=fail smtp.client-ip=52.103.35.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fUBjkz25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6MW2E1zKgHWxnA1zI8zwJ9aHRf7gktyCat/kl6RF2qw6dNKYR+YRvH/YkoDjpRfrTVKpYRtd5OcalUkZP6DfCTWLqPHEfCIjrka/E+2+bCZvi+J1nWM8Ygb9k7UYdNLqMl6hmhMoz/L+T/fx3iWFtjvdC82y5vkbjVvAd606uDYFhMl5VcxkYC7W8F6MHXxCAl4mNpC8HKj1lCspzLLT3BdggO0FNuUKl45o794ezb880MQyl1IfSVYm9cfHfmccyA6VCicx9P5KYULckkKZeJRQcMEEBxTz6k2OQWznJywNL9rX35/O7rpH+lbMLjltmMRShLbPitasIFO1oCNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7rze9LDBuVtInd9L/OBuGnEdd+Pl2HpL8riNDFfi54=;
 b=Gx6YSFZVt38DxBi6E6Pq0v3TsXtFRH/d436l+wWptRfLEWrGb0Tp/FK8QR/mSmOePUBisdNZdGVhFCAtJlk/Wz4aiedrJFPTSQT+cvsqj2vD5n11dYY2J0PBufiFTnL552ULzzwfzYyht9vB7KoMQt9cUNhuvwqRbJ6mE3vLyGzVk77CqcLsqxysE3GRxTq+6uwMxGWVW+guSA9fYt96kAAPk59ffEhozcZckI62aLXZlcZrXYpIy9h2erHOXyg4i6feVVEAFmvJvqPL0A/LcxJswyZDDjPehauzq42GN6WVgfsJ2PbckfjAAEZoRql9dbpQja2wJ1xGhJdub+2H/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7rze9LDBuVtInd9L/OBuGnEdd+Pl2HpL8riNDFfi54=;
 b=fUBjkz256dd8AP3BHGejLmZsQg3TL4ylloDwizyu/jbY1kqtNVtrr5eK0DiP3HokL88MGbcdgJeT2TsuFj+NA+962GQaeamKapuy/JsYhypoqxG49OEcz6/PjRaTFOrv6Wo3rwasR/Nl+hFvOvQRDGMd5DnJn56aZESqNbw1xTmZycPbXqRea/pNovStyrpWSKyGKWoSb5Ag8ji453ZzmwD0XX5UT0xI5gBkyaMDpOBV2//6soFJ9OqKLiQKyEnPBmEWmLr/HTIATLK9HgSCQMjg2yCwuGn/fZ8djkyRYqacB7pXcIaEG1oq9KPcrTJyX6j9oSD9RbU/NEtSnXRFXQ==
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2dc::14)
 by PAXP189MB1926.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 19:07:24 +0000
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6]) by VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 19:07:24 +0000
Message-ID:
 <VI0P189MB36879B75BAD80D203B6390C8E3B22@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 7 Sep 2026 21:07:23 +0200
User-Agent: Mozilla Thunderbird
To: hal.feng@starfivetech.com
Cc: aou@eecs.berkeley.edu, conor@kernel.org, devicetree@vger.kernel.org,
 emil.renner.berthing@canonical.com, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, p.zabel@pengutronix.de, palmer@dabbelt.com,
 pjw@kernel.org, robh@kernel.org, ukleinek@kernel.org
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20260810030714.48100-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0054.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::18) To VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2dc::14)
X-Microsoft-Original-Message-ID:
 <a0a19356-e99f-44cf-bb7c-fd84a516f5b4@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3687:EE_|PAXP189MB1926:EE_
X-MS-Office365-Filtering-Correlation-Id: a04528d1-5142-4f74-03ac-08df0d13400e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|15080799012|23021999003|5072599009|6090799003|41001999006|4140399003|8060799015|19110799012|25010399006|40105399003|52005399003|12091999003|1602099012|10035399007|2607281247196008|260806224601699006|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWR3eDlmdzg1L0hFUHZJMTdJRFJjZ096OTF0MXk3SVowU3VMUWplQ015SFFB?=
 =?utf-8?B?QzlqNWVSeHN1RUpSM1lIVXdBcCtvMWNKdkJtYW1XdXdYQW9ZbzUrNHErdTdW?=
 =?utf-8?B?aUt3bTBRSjFvQnpWNkpTaDRUSXFJTkdNT21ZSkpiSDJNQkVUQ1A4clJqTUVL?=
 =?utf-8?B?VkJyak84TXNReVUxRVdEQmVpNGE0Y29xWGdVOUxGVCtERloyU0tZbnFmV3lX?=
 =?utf-8?B?K2ZIdnNlUGNqaWt4bUNKTkJXQmVCU2RoK1BuK0lkMGlBK2xNTHR0OXJqWS9B?=
 =?utf-8?B?c1lyVVpUbDBrS01kV1lMbFZrb2Z2bk5uVEpjWnhsc2VlM1R6UHl5b2x0OHJI?=
 =?utf-8?B?SjU0M3UxVXdVMHRtb0F3Q3A3LzlBQnlmZzRKVmd4cnFaY09MNjlUTXVOcGpr?=
 =?utf-8?B?cGszeEdvZVhwcnhaNXNXdVk3UUJsM3BjeVR5RXlwbi9pSWtTN05scXhMS2xi?=
 =?utf-8?B?QWg0ZDRFSXBVNVBCTG5rMlVodXIySVAwMHVTTUNzY0hTc3RiTWx4UFZoMzV5?=
 =?utf-8?B?N2FJTy9wWnVPSGdOVURxSHhoQUNHMHhpZmRuWXpmenljaW0wbHdLdjdSK0xq?=
 =?utf-8?B?RlE2bmNyNG4zcW9ER29sUVVOTzQwL3RsTTNRdGtvQ3JSNm52MGIwU3YwU280?=
 =?utf-8?B?TFlIU0hrZkFIU0plOG1EdzN0OWFvWUVPMWNHYVQ2ZnNQTEorTDJtVGd0K0Rk?=
 =?utf-8?B?SU12VllOcjBVZzNXTGRYd2xwOG5uWHZxazNPMWRYN1RVMGo4QTdFNHlQbUk5?=
 =?utf-8?B?ZHVPM210ZEczeEVvaDIyZ3Z4OEs4eHZELzZnY3hrb0RWRU41aWhhNDhLTG4x?=
 =?utf-8?B?bmhIQnhuS3VENTh5V0dHVDUvVWJjQjVpc1B6ckVieTUxN1NZS3VoN2JxSi9T?=
 =?utf-8?B?ZFk4aStJaExoQnppYVpYdjFxem9oUXNQNmF5MmZsYXlVWmJGazkyZk5sUkpG?=
 =?utf-8?B?c0ZMWk1abzU2QnlWVzhiRlNtVmFDVzNHN1lDdnVGb2k2YVVub0hkelF5YTlB?=
 =?utf-8?B?akFIdnlzZlZPN0JINGhUdDFyL09iU3c2c2pkM0M5RmxRRUdXWnFuajg0bVYz?=
 =?utf-8?B?dzE4MUZ5bWlvTkJEY0dFb3U5enpEaGpsQ3BvcEdZNGRHQU5PRVpHY29reTA4?=
 =?utf-8?B?YThMNytFY1pONXNYcU5CSEJZV3FMck5rSVY3a1RRVnkrY3cxQ1dTTStBUmw0?=
 =?utf-8?B?cnNlL0xKT1FQaW11OUdySEZYQWFHZUZvdTY5MW8zZWxvZXMzK1J0WHpxSXFN?=
 =?utf-8?B?a1ZnOVIwcjBvOTFKbWIyQmw3OGFBSXM2Z2puRFhIRnZYZWd6c1JrWGcxMVZr?=
 =?utf-8?B?NU53WHlUV0V2N3NZU1NrREs1MTFwSXVyNjFHdXo1bFQ5N3RZOGFWY2lTSUpt?=
 =?utf-8?B?ZUplcnA2aERTNzY3dSsyYW0rWnNjdHlxS2loZzJoYjRNY3hiemV1NzFnVElF?=
 =?utf-8?B?WmU4dGZtSVozTEdRN2dDOGR4d2R0OUVnRTBqNVl0ZWFDNDh3TDlaUlV1N0Vn?=
 =?utf-8?B?TnFtSDgyUGZ4L3JkMmo4blFDWXdUVHhYMFloRTZrSGkyRzZTNCt4NDh2RjZU?=
 =?utf-8?Q?lQYHHPsmsIDHBZFE6EMoFWBlI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlxUmFKTkt1V0RyRzNuZWlITFRXR29MMVFiYnA4Y1hxeUdkZktPQXdHWWtL?=
 =?utf-8?B?N0RJYzBhWVJCWUpsVndOcEtIU0tocGh6dm5kUnhkK05sM1dNMlgzNmRoY2k5?=
 =?utf-8?B?Q0tNUTdFMk5EWC80TlRsU1k2OC85S0R6TGRlS0Zlb1cxMW02R0RBc1RLUFB5?=
 =?utf-8?B?QS9jdmltclZFbUsyMVdIdW4zK2RHTmJGZFVJZDBPaFFlRFlENWRTNXdEZWJm?=
 =?utf-8?B?eGk3bXhLakQwcEJTMzQraXdzUjI4UEZJQ1p3UnZEUVd5UWNETm1BQmFRcysw?=
 =?utf-8?B?VjhJZGM5Qjgzd1VGamxiMjNhUEZ2SGRSMG80NWcvZ0pOdVZNV0Zsc0lYSGVo?=
 =?utf-8?B?ZGQzbDNZVmlnVFJyY2RWNFBLTFFlN0wrYnRCOEVHU3NzTzZXVTlTVHNUWDA0?=
 =?utf-8?B?RnVOOVJpU21oUDhxZjkvUkx5dGVmeitPalZ2cndFd3pwZmhDMGk2ZkpFTGc4?=
 =?utf-8?B?VnIrdDZMQ21SNThoekswc2JEc3VWZFAra1lySzdWMktzN1czcytqODNxUEVB?=
 =?utf-8?B?aVZXaTRoYXhFaDlTd1JhSXk2Z3JoVDc1WkVOWXlYWUFCZ2VHRC9IbXVXd1pz?=
 =?utf-8?B?WkNrMUJLVngyRWJpTW1pVTExSDhnSG9GQ0VoOTdSVnNBTHZtd3l3UEFiZlpR?=
 =?utf-8?B?QWplTzMzRG54dGh3Zm9EVGxJejVHUzJkTlBnc0Y4VFF1V0ZnYTFHM2JMckZm?=
 =?utf-8?B?K3c3amwwczJITFZpbVRYbGI1dWNYbWhmZGZKMFNGVkJCUGxFcERvSG0yK1ln?=
 =?utf-8?B?OU1PbUVYQ3ZzQ0VSRmR5emkyQ1BUUUJaZkJiZEN2SXJ0YVFzcVRuaVgydEt3?=
 =?utf-8?B?bmdYYk80eThISXh6c2c0T21pcStPYWZaZXpubk5xWUordllPMEV4QUR2NTQ0?=
 =?utf-8?B?d2pYdGEwYlNhS1BEMmpZSnRsWHl6TzNUMW9vSlQxMnJZWUNod1hoMjJ1UUlm?=
 =?utf-8?B?TFhOWUVycTRLNHlOWmUvVzFPYzA2SnRXR1crdHpkMFhjQnNudWJPZ2M5NlZP?=
 =?utf-8?B?Mk1xdzFCOVRXejdyMGcvdkRFSkhsUkw4QXdTVFYyYmwrNFZuUUt4M1FHTm4r?=
 =?utf-8?B?cXBQYkM4UkNPVnNVdGtib01JNVZmTVp0NGwrYk81a3BLQ2d4SmRzd3VncmtY?=
 =?utf-8?B?RXluK1ZrVFNacE5sT0dqMSt1RlV2czJRc2ZneUt2eWpMNlN3R3JmVDlhWTZx?=
 =?utf-8?B?SFE1QUtsR3pXMVl4N2RtVThhQ1pDS0xVK3Y1MWZlcWFOQmQyUk52cUdweG9K?=
 =?utf-8?B?YVlVQVdXOE1TMjJqekpmaGlWeGlPV1NWVGRFQTBXb2ROazlxQlBTTlhsRENl?=
 =?utf-8?B?WHNTZi9lZUlwbjRtZWhROVQwd3VXQzFhMlR0VUpROEZPbUxkY3dqcVB0Mk9s?=
 =?utf-8?B?MGRJSGg5Mm14WTgzN0JZemxxSmc5Nkx4ekN6dXZtVVJKVlJzaEE5aEtydXUx?=
 =?utf-8?B?cXZzMENnOVZuaGUyL254dzZDYWlSYXhvUWZhQ3pOdnhlTlhsTEZPMlBURW1r?=
 =?utf-8?B?bzYwbmowVitQbld1K0R1YXlxZjFrYTRNcjAwNmFHaW9wb0hma201THcrZVo2?=
 =?utf-8?B?YTV3Ukk3YWxjOUdWbnlTRDNvaHJFWFZLWEw3bzV2UGZIUGpoTnBTVGhEbGFU?=
 =?utf-8?B?cHNUS25LaVJiMDNPVmhrenNkcGdQYm1zTEM1QTNCeUFIM1ZpTWVNQTVBMnh1?=
 =?utf-8?B?OVd3czZjSkw1OWI1Q0dpZ0xOaTkwbkJrV1EvK3FFaEliMFUxUnF2NFJBM2Fl?=
 =?utf-8?B?U1gvdXdXN1pnTWpVZlFya0VraXpId0VUWi9rb0J3RDE1WGtJcDZGZ1Y5NGt2?=
 =?utf-8?B?cDJ3Y1BURDIybnF6WmVjS1NCYnhkeFdDMUFhZ1dycENPSGd5S0sxVlREcUVI?=
 =?utf-8?Q?0DBCjAMH/AMcs?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b25a6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a04528d1-5142-4f74-03ac-08df0d13400e
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 19:07:24.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1926

Hello Hal,

Thanks for picking up this series, I've tested it on my fml13v01 board 
in the framework 13 chassis. Seeing the pwms split out into seperate 
nodes is how I envisioned this driver too.

Now to figure out how to get the pwm backlight driver to work nicely 
with an inverted pwm.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>

kind regards,
Maud

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
> Changes since v20:
> - Fix 0% duty cycle support.
> 
> Changes since v19:
> - Drop the oneOf construct in dt-bindings.
> - Address Sashiko AI review comments for the OpenCores PWM driver.
>   In ocores_pwm_apply(), handling disable requests first, then calculating
>   and validating period/duty for enable requests before taking a runtime
>   PM reference or touching the hardware registers.
> 
> Changes since v18:
> - Address Sashiko AI review comments for the OpenCores PWM driver.
> - Fix runtime PM usage count handling on probe, error paths, PWM release
>   and driver teardown.
> - Reject period or duty cycle values below the hardware minimum.
> - Restore PWM registers across system sleep resume.
> - Return the real error from devm_pwmchip_alloc().
> - Preserve bootloader-configured PWM state during probe and keep runtime
>   PM active if the PWM is already enabled.
> - Use synchronous runtime PM put before possible teardown.
> 
> Changes since v17:
> - Simplify the code. Make it more readable.
> - Restructure the driver to register the pwm chip for one pwm channel,
>   because each OpenCores PTC IP core only supports one PWM channel.
>   Drop starfive compatibles.
>   Add patches to fix the dt-bindings and device tree.
> - Support runtime pm and system sleep pm.
> - Disable the pwm module and reset the pwm counter before updating the
>   period and duty cycle.
> - Improve the descriptions.
> - Update the dt-bindings maintainer to Hal Feng.
> 
> History:
> v21: https://lore.kernel.org/all/20260701074442.7714-1-hal.feng@starfivetech.com/
> v20: https://lore.kernel.org/all/20260629063601.63917-1-hal.feng@starfivetech.com/
> v19: https://lore.kernel.org/all/20260615155759.129210-1-hal.feng@starfivetech.com/
> v18: https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivetech.com/
> v17: https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/
> 
> Hal Feng (3):
>   dt-bindings: pwm: opencores: Update compatibles, examples and
>     maintainers
>   riscv: dts: starfive: Correct pwm nodes
>   pwm: Add OpenCores PTC PWM driver
> 
>  .../bindings/pwm/opencores,pwm.yaml           |   6 +-
>  MAINTAINERS                                   |   6 +
>  .../boot/dts/starfive/jh7100-common.dtsi      |  28 +-
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  67 +++-
>  .../boot/dts/starfive/jh7110-common.dtsi      |  27 +-
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   |   6 +-
>  .../dts/starfive/jh7110-milkv-marscm.dtsi     |   6 +-
>  .../dts/starfive/jh7110-pine64-star64.dts     |   6 +-
>  .../jh7110-starfive-visionfive-2-lite.dtsi    |   6 +-
>  .../jh7110-starfive-visionfive-2.dtsi         |   6 +-
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++-
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-ocores.c                      | 298 ++++++++++++++++++
>  14 files changed, 518 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/pwm/pwm-ocores.c
> 
> 
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> -- 
> 2.43.2

