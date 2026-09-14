Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013078.outbound.protection.outlook.com [52.103.51.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E127FD43;
	Mon, 14 Sep 2026 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364838; cv=fail; b=nctAVYEbxZBkMnNQTD1gJMJZJwGtdkrBvMI3ktvC4dICILFn20fByHVuIy41NSqJRacFVCRynY587Ydk9KBsXoGCk1WSfNV7XPGn2xUUfjpp6wOKE7SR2sbyRMpSAJS11XtkG+8aqD0ICjGNZfkArIRdD+vJ7aogQvAI9FJ+Tww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364838; c=relaxed/simple;
	bh=IBnkZx/8i+lqPqufD4+4CG0F8yBLr8cREgr0jkMLocQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ax1Z79MiAPxRQdWi/Yj1gFjuZL7VGfXF1tEhLs9UcOLhNLgvSWwCHtpcUVd/aHp+o9zNnB52sb4ul9lGxhfBdpWu3pBNEDEOvcRaPMGswFEpr0FfCG/OW8kMwSKxjgf8eb7He/AminD06oUgI1PqXEcJ01A58sbhmzwJgWTwyIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ii5KPtUV; arc=fail smtp.client-ip=52.103.51.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ii5KPtUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8s+HnjqoaEN8rf+j0Uc1IaCmdw0/SoCD0EEjWDZxcIZ/Y1koiVeu4ybfnDa8IPBJdqVMsmCeh80IJbihFqTXy6O5+qt03K7fW7JB2RlHv/+6cvCVQUtq8OfSjKbmGRb6GHU3Qy+tpSmWmbTU2SWIdhIXwSbK+R3Dd5+EM1dkmuhHRAp/MMOrjK/MOkW2E8rMhEToZc17cHaWmEh5SpFXxmTq2Q9YDWAI4wovdILFbkn3DnofKzGlFKbkxQdmU70l6/6SUHfi4sd30fGLp6CSiPg63h9y0YZEEyfTzL0bPMQiLVJ7/FErqKryYfjpq1ykb1V4Tj6AHGWi4vk0/90XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwWqZ0ePmC1u0y1LxUl0TU/G8Du6NF7G6Wnvu4ZoVjI=;
 b=DYduMEHML1gPg4fwJmPpdtAIa6ca4WCfJXw3Flud3wIGiMbuWqZPV1EiCHf0pSakdfeYBkf7G3S1+mcaJmUUU6ut1xpT7KbcADLYCnVGmrK9CasYubHfTRSucsN49q3BwSCmAKauDh3cAIa3OqvSP2Zf45C3wW4QjwkgbPFHz75CVdTiY2JcwLDOAMQEyvKu6L+SsRfuenDz4yOdRP662GU+uy8FCCb/Jx67jBjY/p4317jOzp78WfS1x4mzOFTC8BGKDoY34Kfm3czxBKDsklP5ApwLzG9EbwBbN7LU7aGxNRX3bIIzbeDeZNfzCUwO3qPVLlN2FtCOEaoM84uArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwWqZ0ePmC1u0y1LxUl0TU/G8Du6NF7G6Wnvu4ZoVjI=;
 b=ii5KPtUVOVgfrzB5CA7XVhqWjT4XAtFiQ8D6Zm9Wu0mT5y4hKYhxt0LjXwO4YytX0RDlG8HcfSGGrEBtFSmD7XDq+xBvN4ssCuPabHSNrqxkqbPY2z0eMOfMyH+MxG3zyxuhhlJUwG7bqSZz3872866z7bh5vxJBcpJLxtUwAmIWnPJBb1dsdkkxMhJDxJ6MkLsdCgFuO5xDTLn2ThljV399dGHJMK9B7Co8SEl/zRx2xNGPUOU5revSpGEq9mV0xzGVmCceaDe32QmduirO/XZLyWjSGcTSF+ha4WRn3aqKc3xw1uS5KLZQv2SFsuTavl2yRDknykoLxgLC5xbXzA==
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2dc::14)
 by PR3P189MB0939.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 05:47:12 +0000
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6]) by VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 05:47:12 +0000
Message-ID:
 <VI0P189MB3687EEED5AA685C67D0EFA50E3BB2@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 14 Sep 2026 07:47:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "conor@kernel.org" <conor@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org"
 <pjw@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "ukleinek@kernel.org" <ukleinek@kernel.org>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <VI0P189MB36879B75BAD80D203B6390C8E3B22@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
 <NT0PR01MB110215832CD3F81372D96302E6BB2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <NT0PR01MB110215832CD3F81372D96302E6BB2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::33) To VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2dc::14)
X-Microsoft-Original-Message-ID:
 <dc8c2fa2-f560-4690-bf30-46edbceb93a4@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3687:EE_|PR3P189MB0939:EE_
X-MS-Office365-Filtering-Correlation-Id: e760884c-85ea-4a41-c6ca-08df12239fd9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25010399006|23021999003|41001999006|24021099003|51005399006|19110799012|6090799003|8060799015|5072599009|40105399003|1602099012|10035399007|260806224601699006|12091999003|2607281247196008|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEplcUZFMURJbWg1RnQ4UlVRRlR6M2lEL0dRT0UwUWlIMmtGY2tGMWRIRW1V?=
 =?utf-8?B?NnZneGduT1ZuNnBRL1E3NnhDYVFjNmc4ZjFSNEx2bWRFWmhtYkI2cE56M3Ri?=
 =?utf-8?B?cDhLOThZU1RpWVFHL0VGQkZRbWIzMnlzcVdVL0dJYUdNSmwxQTIzWm51Z3Jp?=
 =?utf-8?B?SXByN2hJRnRxV2M1cVQ3eG1jMS9oMTliZDRoanJJRytLMzlmMUNiNzIvNDRw?=
 =?utf-8?B?UkszaWExWEFLMUpPQkllNzJzeGZ3clV5eFdwVWpjMWdjTjl2MWVZTmRFZ3dy?=
 =?utf-8?B?cU1wN2NkcEtSeTh1eThUYjZHbldLY2VLTmN2TVJmSlBGbDdpS09zeHh4UjhT?=
 =?utf-8?B?YVk3UFdDbWxGOWY4QmFhR3JiS2JUc05zb0JKdXhBNkR5QW84MUZ5Rmh4Q1NP?=
 =?utf-8?B?czRGcnJJRXBRMHlpQnJ4Slp3VFl5dWRuSkV2UWVBd25PWkpKL3lGYURscFVQ?=
 =?utf-8?B?RTlPMlRiWllwWmg1UDBJQm9OZkVISFZTWk1xNCtXdjd3bkovV0xtMjlwaFVi?=
 =?utf-8?B?WUxnSEdKb2MvRVhkLy9GdE1xNlhCZnRxSWF1YlAwUzNGZ1RIUWpKU3lOTzRs?=
 =?utf-8?B?MjhiWjJWWmkxMllnRXdDZ2hZZDJ4dWprVnpKdGk3aUFXL1ZRbE1LVnBlVXJS?=
 =?utf-8?B?cjhzVlZNY0ZYN2J1eFlySjAydGUvN0VNSG0vT1ltOUtVZFZsQmlDVkxvWi9P?=
 =?utf-8?B?bFZoRnU0TGJaRmhHb2xGa1pON0h1VlFJbUMxV1M2SlpvK2lMYktod1hkL3RF?=
 =?utf-8?B?YVd1T1hHRFlhOXIyRWxVZjRPUDFvZmlzQk9pNDNsMWp1VkRzK2lyeUlYUnlR?=
 =?utf-8?B?NldzV3IzMFhNYlBsSVNuNW5PYmliWG1vOTJXejM4MnhjZmU0Z0ZScjJmZVBS?=
 =?utf-8?B?Wjl5T1JxRk9PdERaNWpya3ZoTSt0Q09tK1lsYVRySHZIczFVREVzUFRaSkZR?=
 =?utf-8?B?QzExODJLVW15ZGlnc2lQeGhRM21SY3hldHkwYlcxUDdFMlRwdnZ6U09admtT?=
 =?utf-8?B?MnZTMGpiNE5RRENxN3owMDRMMElycG9FbXk3UzZHSGczbFBVTVNVRWlKaEox?=
 =?utf-8?B?cXJMV093NjZSeHJsakptTVI4c3Z6ZVVjZHo1aXBpTXQrTVBGZHBmSGZaLzl0?=
 =?utf-8?B?Y2dRVHVuRlM0TWVvZVZNSWl2MFY0UUtldlc1SVVUTDhDcFFTdHl0QjZ5cXFz?=
 =?utf-8?B?YWVqY1dIUzBRRzVxRDJmWENEZ2FweU82ay9tcmtnSFh1NUpMbmp6ZHJZQkps?=
 =?utf-8?B?N3J5QThKeDBZSDRqV2kxTmxMQzkxcGl3cXpNY21TaFpyYmdDeFhoZE5oQVlW?=
 =?utf-8?B?MDJBWTdZM0UrcHhkMXovOXRNalBKMnN1STZiaXh1czNHSjBQcHlkdzkyekp2?=
 =?utf-8?B?OFI3M2k5dm5zdnY0NE5tTUVNczRhQW5MR2gvR0NvK09oRDVtWUVrNUVJcTFF?=
 =?utf-8?B?TzRUZGE0bzhmYjFHeWpFQjJHelFBN2VzLzh4aW1ZSHFNVlRBb01CZnc2aS9y?=
 =?utf-8?Q?M//A6eOIPbKBHk5kvmItc3SbOlx?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2JPb1ZQVXBSVXg3ZmJZajE4VFlwa1pQZDVKdVR6bXBxYkU3ZXVmMEc3WUxk?=
 =?utf-8?B?aHovMVErSmU1L2xkaVZkRzQyTlZOTTY1dXRyRTVoS0FVSGlacThtSmpuNFk3?=
 =?utf-8?B?ZTlsQ0xzOUdVc3NXRTlDb09DTks5eklZTkcrZkY4VGFNV2owRG1TbDNJbmRi?=
 =?utf-8?B?cmtQNGc3TVA5UjUrL2wvNGlrbVE3bk8yaGg0eGgxblFTQ1RjNmJyVzlkVFpL?=
 =?utf-8?B?dU56SE5ZTWk3VDg2UHM2c25RNHNDMHJQU2NHU2pRUDUwNjdIaU5PcjFNT0Zk?=
 =?utf-8?B?YkMyeTc0UlVCVzlGQ3V6YzMyUWJtbTNtYTZTQnRPbGxOL0RIMnlrTGVTcHRj?=
 =?utf-8?B?bElvMkliNWpIbTdFSk95aDlZL1BXSjAyWjhtTUZ3bE5sOXJ3YzNSSXMvdllC?=
 =?utf-8?B?QTU2dWVtTzROVDZrMXhNOTRwcGJBQ1pENWRVRWxBdU1MSVVlRmdNeWp5Vy9O?=
 =?utf-8?B?Z2xONHdUMVk5WTlmQ1FvOWROZzgzRGZOdCtpQzcvMEZsVmJZVUUrMnBhRmZ5?=
 =?utf-8?B?RDNwNGtJZkdobzV6TUpYVU5ZTjB2TldqRnJ4RFdCS2xoMTk2azV2a0t1ZzhQ?=
 =?utf-8?B?WlJVUk9RK3lhS1g0MkhVUXJSR2pXdElIWEhoSklQd1A5TWZXTCtuQm9RTVNM?=
 =?utf-8?B?OEY3SFowZWVkU01FdlRJQTVPejNJblV1UWZ6Qk5IcktNdHZFT1p3WGtvSUNr?=
 =?utf-8?B?b3BkT0dKVGMxUXoveWtlZkdna3lmRk5wYUNIYkN3L0pOMDFLMk5pUERiWksv?=
 =?utf-8?B?RUp4dHBPTXZvWmJKR2tPNzFKNjVjem5KOWRwRy9ld2JxWDBiMzdCVlltY3cx?=
 =?utf-8?B?ZGNOZEM3QjB1enVyRG1Hd3VSWUtTeW8rREQ2RmFUaDg1UGFZNlhhb2UraDFX?=
 =?utf-8?B?RTh6VStodDlHYkl4SHJ1Y1Y1SVp6MTJkaGhWdDd4dUY1VWI0R2RjVWgzVDRE?=
 =?utf-8?B?MDM0UUZ2b0J5d01DRXQ1cHNmc3VjVkdzanlvZDg3L2VmYzFxaEVPNTBwMVEw?=
 =?utf-8?B?MjlHMHdZTnJjTTNocGRwZmVhT29JM3ZqamNZSzE4SnVzdTJIMmRLSktPY2F3?=
 =?utf-8?B?cWFPRWoyY2pxdlRwWWh0ZmNSbGZuazlVbTVKNVd0bmM3eDhYTmNQVXptRGpF?=
 =?utf-8?B?bHlHOVpVdURqVTZxWWtSbUlBYmRmMC83VEY0WU1uYVd0RnNtTlBOTEZJZmJu?=
 =?utf-8?B?cnBsOW8wWE5MZS9BbllMWUw2UDZEQUc2U05UaENYMnU4TXhwZDgrWnYyMjF4?=
 =?utf-8?B?cjRLSEE2cnBYVnR3M3c0bENXVFMwUk1ScVBEY1g5SE03VmNQaFlXZm5FdnEw?=
 =?utf-8?B?b1N5QS9YR3pYN2Q3c3pob2xzaFVrdFlmcmdIVThFclNOVXI4dEtaNytoUlZF?=
 =?utf-8?B?TXozMFZteDk1VE1pcTV3TlBCY2FObHZHR1pKZ0dXNzZiRks3Rlh1TE1XK1lZ?=
 =?utf-8?B?ZnVVTS9yQjdTUnZEdFJVOEM1Tk9Nb0NkamFGY2V4bVBoMFRKSlZQWThmV0hV?=
 =?utf-8?B?ek5pUmEwUitVbXljdTZ3V3h4TjBkUVVRT1dwdkREUXBXOEZhMllkYS8zTTky?=
 =?utf-8?B?Vlk1aXo1VkROQk1mTlc4RHZNOCtwcjRqUytWclF4SG1QRmY1cy9JM1dUZVFy?=
 =?utf-8?B?S1RTckxjTlMyWkJBWTlsRHIrRlhrV1RNNXVtMmhaN0NtTGN3NDBuWkZKL2RS?=
 =?utf-8?B?YjkxVzBtL2Q5M2lPVHpGd3BaS3RrUlJQYWR1dHYrSmlBTHBCam0yQjJuSDZ3?=
 =?utf-8?B?anhoR2Zya2lJZGJxcnRYS1U2M05FaHBJcWhqOUhnZnkydXZ3QVpXcUVNNytX?=
 =?utf-8?B?OEcxY0RsL0YyU0hxdG9udVV6Mk1COHRMU09STDFDUjlianB1YmhMZzVpbzNa?=
 =?utf-8?Q?UScAB3Ko0Az7+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b25a6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e760884c-85ea-4a41-c6ca-08df12239fd9
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 05:47:12.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0939

Hi Hal,

On 9/14/26 05:02, Hal Feng wrote:
>> On 26.09.08 03:07, Maud Spierings wrote:
>> Hello Hal,
>>
>> Thanks for picking up this series, I've tested it on my fml13v01 board in the
>> framework 13 chassis. Seeing the pwms split out into seperate nodes is how I
>> envisioned this driver too.
>>
>> Now to figure out how to get the pwm backlight driver to work nicely with an
>> inverted pwm.
>>
>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> 
> Thanks for your attention and testing.
> 
> To work with the pwm backlight driver, add the PWM_POLARITY_INVERTED flag to
> the device tree.

Yeah I got that, the issue is the backlight functioning in the wrong 
way, it doesn't invert the value map. So max brightness is backlight off 
and min brightness is max brightness. Might need to add some extra 
property to the pwm-backlight driver to allow inverting the values so 
the brightness works as expected.

Unless I've somehow missed something in the pwm bindings.

My current changes:
https://github.com/SpieringsAE/linux/commit/bd1ce4bb1740d86c42206effec962d470cd5c5ef

kind regards,
Maud

> 
>>
>>> Add OpenCores PTC PWM driver which is used in StarFive
>>> JH7100/JH7110/JHB100 SoC.
>>>
>>> I will maintain this pwm module in place of William.
>>>
>>> Changes since v21:
>>> - Allow non-zero duty cycles shorter than one clock tick to round down to
>>>    zero.
>>> - Drop the .free() callback to preserve the PWM hardware state after
>>>    pwm_put().
>>> - Update the comment.
>>>
>>> Changes since v20:
>>> - Fix 0% duty cycle support.
>>>
>>> Changes since v19:
>>> - Drop the oneOf construct in dt-bindings.
>>> - Address Sashiko AI review comments for the OpenCores PWM driver.
>>>    In ocores_pwm_apply(), handling disable requests first, then calculating
>>>    and validating period/duty for enable requests before taking a runtime
>>>    PM reference or touching the hardware registers.
>>>
>>> Changes since v18:
>>> - Address Sashiko AI review comments for the OpenCores PWM driver.
>>> - Fix runtime PM usage count handling on probe, error paths, PWM release
>>>    and driver teardown.
>>> - Reject period or duty cycle values below the hardware minimum.
>>> - Restore PWM registers across system sleep resume.
>>> - Return the real error from devm_pwmchip_alloc().
>>> - Preserve bootloader-configured PWM state during probe and keep
>> runtime
>>>    PM active if the PWM is already enabled.
>>> - Use synchronous runtime PM put before possible teardown.
>>>
>>> Changes since v17:
>>> - Simplify the code. Make it more readable.
>>> - Restructure the driver to register the pwm chip for one pwm channel,
>>>    because each OpenCores PTC IP core only supports one PWM channel.
>>>    Drop starfive compatibles.
>>>    Add patches to fix the dt-bindings and device tree.
>>> - Support runtime pm and system sleep pm.
>>> - Disable the pwm module and reset the pwm counter before updating the
>>>    period and duty cycle.
>>> - Improve the descriptions.
>>> - Update the dt-bindings maintainer to Hal Feng.
>>>
>>> History:
>>> v21:
>>> https://lore.kernel.org/all/20260701074442.7714-1-hal.feng@starfivetec
>>> h.com/
>>> v20:
>>> https://lore.kernel.org/all/20260629063601.63917-1-hal.feng@starfivete
>>> ch.com/
>>> v19:
>>> https://lore.kernel.org/all/20260615155759.129210-1-hal.feng@starfivet
>>> ech.com/
>>> v18:
>>> https://lore.kernel.org/all/20260515054723.25024-1-hal.feng@starfivete
>>> ch.com/
>>> v17:
>>> https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfiv
>>> etech.com/
>>>
>>> Hal Feng (3):
>>>    dt-bindings: pwm: opencores: Update compatibles, examples and
>>>      maintainers
>>>    riscv: dts: starfive: Correct pwm nodes
>>>    pwm: Add OpenCores PTC PWM driver
>>>
>>>   .../bindings/pwm/opencores,pwm.yaml           |   6 +-
>>>   MAINTAINERS                                   |   6 +
>>>   .../boot/dts/starfive/jh7100-common.dtsi      |  28 +-
>>>   arch/riscv/boot/dts/starfive/jh7100.dtsi      |  67 +++-
>>>   .../boot/dts/starfive/jh7110-common.dtsi      |  27 +-
>>>   .../boot/dts/starfive/jh7110-milkv-mars.dts   |   6 +-
>>>   .../dts/starfive/jh7110-milkv-marscm.dtsi     |   6 +-
>>>   .../dts/starfive/jh7110-pine64-star64.dts     |   6 +-
>>>   .../jh7110-starfive-visionfive-2-lite.dtsi    |   6 +-
>>>   .../jh7110-starfive-visionfive-2.dtsi         |   6 +-
>>>   arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 +++-
>>>   drivers/pwm/Kconfig                           |  12 +
>>>   drivers/pwm/Makefile                          |   1 +
>>>   drivers/pwm/pwm-ocores.c                      | 298
>> ++++++++++++++++++
>>>   14 files changed, 518 insertions(+), 24 deletions(-)  create mode
>>> 100644 drivers/pwm/pwm-ocores.c
>>>
>>>
>>> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
>>> --
>>> 2.43.2
> 

