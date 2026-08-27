Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023139.outbound.protection.outlook.com [40.107.44.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0363AB274;
	Thu, 27 Aug 2026 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819919; cv=fail; b=M9XfUXa9bIy8CEU0cIT5v5BiJ+Nv0DTz+qSUw9O3s6JEh51Qj0HiBRLAbeCsldPa2h+wDR3AX8sR1n1IHEgYUtE5knKInOvvrg5xa4VB+1uEK/mNiCbuffNpvbYy0+jUDnRZepBJgaz0ugZxk4jEHaunzXLPzA7tZSZR4dMREMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819919; c=relaxed/simple;
	bh=ktWfhfKINo+HshmekxN9sTG6eSMcE0CcNQPzve5VA9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AP83jdqlwqsfQML537pgujXaTSrzERQa/J7jXREBljn5nUClnqgn052LHUjjVyShomWi8I7DRn/zb4tbzYYfVEAe5Kak9EEEOMQEtI/QVhThdVfMJDrl1bqh1vp1sUZ633eNArCmrr4G+XO8KbPr+ss2ah/KHMCeXgGjiBEKmKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Nwjlj/Db; arc=fail smtp.client-ip=40.107.44.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Nwjlj/Db"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkdpnGlvrTfdHXohZqTAIQMTr8yozNzE74GMnv5WHwxGNBGM3zxAs9oAdo9BMZJ0D5KuKSt4ZHA2dC481cbnho1pSgNtGJGlalchH+ZxpOKbQeYWyBDxnS5N9nUdiwHBK5EspyLS177t/8n++hNJYjPAcGPu50jMCqRF1g6AD8Kg75IrLobc8npTuO6XqMtv495D89ylOM4Wz3VuekkgFzSKn0q3rRbcRx1LH7xp7OyTk4lZrJBq0/oZOJEsu5k50qa+cotONtv/k1BzDWYEToQnlbMVER7J3+m1ftv7j2u9XSTCEPlBb+DR6xnCzk3C57JPSBYGz8yc7TVU421mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+HpEG5thsB7RzYByLx5SPeCXSgrm6/9JgVi1wddJ5s=;
 b=fROD/3kmhq++Q4x7OxdIPON1/g1T93vpphkDKkzDuylIDYB0rVnGQpUOUbi/X5ZRpMJyukwelz93ToU8cQ1wudL56/IG3tLSzQkiIpRPvhG5euRDzCY79jvQM62N0FLYK9I7vqOe6YL0xDVz7+K6WepQ9tm2eJQhxdGUB/hYgNSBWeklnlsac/dUe1b1EtrRgt3jHYqOjRF54K+G2JZQvWZqSc1LvGkgu8PAYMBkw5zuUPmzv2eM3aMgEHUyx4nGo1SctGThH6wBOVwn5tHLhXnYhv6GCdnVJ+Ivw+HJs5b7SN5Xf5DpjsiB97JMg0QLqn3tL2RRYr1itxOQ4R2tOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+HpEG5thsB7RzYByLx5SPeCXSgrm6/9JgVi1wddJ5s=;
 b=Nwjlj/Dbs+61hyfzumSYL8/+TZ5HyF9R58BBcjqzl4ddY7ktq6VpY8Gr252QVRBDiTQ3SUNczjlN2KfmO5lZpTWzHcFcs+4FA8tKVPAUVz4uZh26dNfeLn6dmu3rsveTvK8lMf/F56OxwwqXs3Zgc7qokgzBciICmU0yFm+7p0hwttNo2wV/pu5+ynRGouBsCk+aQJ/gpU1d1K2vYo1y39FL17G3pixCRDGqiEM5Is5x9UZX7BzgIuzAp8kAsk5D4RWc/tweUZiWwlzZjl1D2m9aU/TqlYZILkMwqvFyZyRG02xWJ0LxL+JinwqxQ/FtmI1spsg2HoIRpUX99iYBxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB8571.apcprd03.prod.outlook.com (2603:1096:820:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 08:38:32 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 08:38:32 +0000
Message-ID: <3b34e172-8224-4726-8064-3c86bd397129@amlogic.com>
Date: Thu, 27 Aug 2026 16:38:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pwm: meson: Add support for Amlogic S7
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
 <20260521-s6-s7-pwm-v3-2-57b073fbafef@amlogic.com>
 <178705763029.1733024.16040030322013834677.b4-review@b4>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <178705763029.1733024.16040030322013834677.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0152.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d7e305-25fe-4a5f-3977-08df0416937e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HH43JShX6BXD6n36ihRg4ctJmPTtbagfGNlRmOcnKNhZkf6FXp4FvTqUotUg1z337XNxO4NL6goHnvnYNlyfwB4dy/rrwRk0cVHwB6jbGQn0f6+Vgplw3cWiLrvqE44Gy6tLQszBSBb303Cm6lVpU2zMEqlufuXKqMNKz443UylqlGv9l199rnV82d8bBnEJfww1x7do2DdSclNP/gNdhttTMCsEPrqCtLGYphDzcLjr1sHuos5Uby1i0k75Mp+wMO4dgi03pOVGWdbkwYDYys8RAJsW0t7RhDQrs7yLbFmQkCvdQxoo9JREgz5Yo/RWtx1uRXWKxfWvTzkibZ2gBmIiIOxJZoaFxPRs7tumPTkzJL/uF4Sq1agXgL0Te9+nMxBmPgeSHAQ+78yak8gmtKnlMlzsU96TzxG8FmSp+FaT8mV2E9J+U1gg4f9WjaUYL0B9yKb2PA8EuouTTAbEWDTivsHcSrgw/Awbquzj9OiaAHn2JtC3OJDhnLfPnsS1JnKcRr/j+ZTBR65W8KhULIEppU+VomXGOVjVTgNc95qoeEpi4yIL5wyvc35+coJw4RZoSqhuxe71n93vUSC7YNWHbIEHRpgZKTi0MzKOZwquRtjbrN758CMZNPiuuHEpIZ68RLihicJmFhjrIufoxnQ60DY0jzscVj0w1cNP2fc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEkyTE05bm9rc3NkNG1GSEFjdmFvcGZNS2pDZ3QyWmlQeEkwUmVVQkhKUU5u?=
 =?utf-8?B?b2ZsNGd2RFJaclRFdzdxMnRIR0ZSd005TlF4MHExd3FTUUkzMzcvTVZyR0Vi?=
 =?utf-8?B?OW5RRDcxVWg1NEkwUldSZjd0UnVETjZxR1llRFROZldwdFpFUHQ5Z3JablpE?=
 =?utf-8?B?aThQWkhtN1dHb05KYW14YzhMTFBTK1hpMzZ4WTdGN09KY2VWd3NmT3huYUdT?=
 =?utf-8?B?Rkgvcm53SEllSTNaN1BibjRLKzBoR0N4Mm12b0NSdURHQUtJK1Nhd2Y1QWYy?=
 =?utf-8?B?eE1vRkJQMUg2R1R5NDJsQ0Y3SmQrYWNkeEZjejZ5OFNSa2RlUmdCRlhVNVho?=
 =?utf-8?B?TUNxNEF3VThvY0ZuR1Q5MEZ1OUVDMUUyMTNSNTdidXM2alRYZm5ra3hGcDNp?=
 =?utf-8?B?Q3lDS2UrNVVrSlRTWlRJSjRmbnU0YWJnTGltL0gxV09wV05qVzR2UGFPVEhM?=
 =?utf-8?B?ZUpIZ1N3U2toN1VwMzZVaGFqck1na0FQcHQ3Qm96c1pXWkp0TFkzcUQzaGVp?=
 =?utf-8?B?b1NUT2Y1bjNVVkxVR0FXRkpaTThIVmlyNnVhVGlxTVdOMzV2NnNwRXJlNFEx?=
 =?utf-8?B?UGJLZ0pQZnIyc213R3dJMmpwUXRTSHoyK2kvdlBBa3RTOU5uWHpZS25aczhQ?=
 =?utf-8?B?b1lUdGd1Z0tINDRqbmh0Zk1JcGllWjN4M0VMN1Ird3BobTVCQmRvQlFTNmsw?=
 =?utf-8?B?Z1MvM2Y3TDdrZTlOeWt2N0VndWtoOHpUMVF5REI5OExTdmUvdUsxK3pPcTlY?=
 =?utf-8?B?Sy9yQnIzRlF3cUpxQkNUbmcxb0hnTmxtVmJqUGh1OFFYR2NIYXY3QldvY3Vv?=
 =?utf-8?B?a2pTeTE1RzRjWDhJSXdFcHphRXhFYzRBdEgySnBKVmFHVnlxUzJNdEprenov?=
 =?utf-8?B?dHF4S25RZlVHVXI2Mjc1ZnBIcnR1allxTXRQb2lLR0d6ZGVPVmlJZUZSNGhT?=
 =?utf-8?B?YlJRSHgybmdJdE8xb21ubVdFamxlcU1YY2VER1Q2UVcyeFRleEdrazNtbmFw?=
 =?utf-8?B?UkQ4NG1qOE5ZY3hQMzlFYnZleFlUUXlrY25KeDUwdTAvZEVKZUdQQThLbWhN?=
 =?utf-8?B?U3FiRDVnV0E1YUpaU2tZWW14QkxYUHVXclo5ZWdpVVNVMDBhSFBPQXF2YkxH?=
 =?utf-8?B?bzN2VVNSbVZhSlhiQ0M2OU9IajNQTitNT1Q2TU4rdnkreFlla1lxME1wMStP?=
 =?utf-8?B?ZWtZREt0QytlNGF4eElGdSs3MXQwckJxT2FMTGhOakxtSmJYaTlicUJKSVFI?=
 =?utf-8?B?MWxyVDdEWVYzZGlpK1ZVN2tlU21YZ2gyYXRhdWRNbFAxNzRxRUJRZGF0a0pI?=
 =?utf-8?B?QzE0Ynh1RGtrYlowRk52QncrS3RJSHg2dXN4R0tsWm96TmhORW1IdG4vdDhB?=
 =?utf-8?B?TWFtWGREZkI5VzNpekw4cFlBY0hTNmxnN201Y2xGK0YyUmpuaHozSlVwQnlP?=
 =?utf-8?B?N1dHUFg5cHNoQUVIUXI2RTBxY05IZjBOVDBFbnJEOGpnUDdwSHJ5R1BHYlJX?=
 =?utf-8?B?aW85SnNFUGZiTWIrUmpOdzZERHVJMWVRKzlBck5DNlNTblFaWSs3c3JsVzJX?=
 =?utf-8?B?RUloaGlKL1ZwclpZeEdLaHAvL1BVaFJlSmZCK2lCcmw3VU1GbmdDRlVvU3Rr?=
 =?utf-8?B?T29tSURkVlptTFZhMGFpTENxZGE3Rm4ySy9aQVM1SCt1U3c1V3dkbWtPbVc1?=
 =?utf-8?B?M1lWM0VpQnZUV0FmNXViUTJUY21nY0EwaGRIVVNYVXh0UVc1RjN6QXk0cFNs?=
 =?utf-8?B?ZDRpTDZXNlJQZzA1ZWJubVQwZllQRzIzaE80RjNYbHJHamI4cFdoQkJ6dmtz?=
 =?utf-8?B?bUFadEZObG4zTit6Tnp4SU1mZ1QvR2JWMzdJVTNpQ1dIMmRMazBxVUJpVTFj?=
 =?utf-8?B?c2E0OWx5bHFWdzlPREhFTTRmODh0SW1JaWcwbDhPTndwdlNvUkZMTEl6Skht?=
 =?utf-8?B?NHpuNGRGTnAvT05hd1NDMmtRS2tjRTYvR1JzcVp4a1RrWEZIQkNvNjlCZFZR?=
 =?utf-8?B?ZHl1d0ppblBWTTQxU0VqMmZwcWZwK2FQM2l4THQraUhDZ2NnZjN3NEREbzg1?=
 =?utf-8?B?RDNxZDl4T1pSV0h2K3VSUHRTNnRyWEd6bDd3MDJvRWpnQk1DSjJCYlhoNXRu?=
 =?utf-8?B?WmdNSHQxWTlyYjdDV1VBdnhCM1pFMGFXcWJLeUEyb2pQOEVydGdmYXBWRzVz?=
 =?utf-8?B?VjU4NjVmeFpkTU4zNEpwWFI4cFZud0ROT1JOZ2Ria2hGVnh1R1VSVG9TN1pI?=
 =?utf-8?B?U2I5MXdTT1lEaXhCcHR4YVM1dVRVVlQ1SXVkM0JubHp1R3F2T1Vaa0REVGFo?=
 =?utf-8?B?eDB4NHlWbW9WWVRtTng4alp0MWM0U0pidmFtYkp0ZjdrMWZRUnVSQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d7e305-25fe-4a5f-3977-08df0416937e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:38:32.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySQhbVdPSxhmTmf+J42W5sDwYtwFFf3RlgmUQOmCOG1Cqkbksi27U4zlti45NAjG7mbjIVTG78ecCM49ljWMUSnaPdr8/KyP/zJ6J0cdkrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8571

Hi Alexandre,
    Thanks for your review.

On 2026/8/18 20:53, Alexandre Mergnat wrote:
> On Thu, 21 May 2026 08:26:59 +0000, Xianwei Zhao<xianwei.zhao@amlogic.com>  wrote:
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 8c6bf3d49753..66c41bf036de 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
>>        clk_put(clk);
>>   }
>>
>> +static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
>> +{
>> +     struct device *dev = pwmchip_parent(chip);
>> +     struct meson_pwm *meson = to_meson_pwm(chip);
>> +
>> +     meson->channels[0].clk = devm_clk_get(dev, NULL);
>> +     if (IS_ERR(meson->channels[0].clk))
>> +             return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
>> +                                  "Failed to get clk\n");
>> +     return 0;
>> +}
> This adds a fourth channels_init callback, and after the series
> pwm_s7_data ends up differing from pwm_s4_data only by .npwm and by this
> function. Would it make sense to share a single init between the two
> instead?
> 
> What blocks reusing meson_pwm_init_channels_s4() as it stands is that it
> needs an indexed clock lookup, and there is no devm variant of clk_get()
> taking an index, hence the of_clk_get() + devm_add_action_or_reset()
> dance. devm_clk_bulk_get_all() (include/linux/clk.h) is however both
> devm-managed and index-based, and of_clk_bulk_get_all() is implemented as
> clks[i].clk = of_clk_get(np, i) (drivers/clk/clk-bulk.c), so it performs
> exactly the lookup the S4 path already does, only with automatic cleanup.
> Something along these lines:
> 
>   static int meson_pwm_init_channels_per_channel_clk(struct pwm_chip *chip)
>   {
>        struct device *dev = pwmchip_parent(chip);
>        struct meson_pwm *meson = to_meson_pwm(chip);
>        struct clk_bulk_data *clks;
>        unsigned int i;
>        int num;
> 
>        num = devm_clk_bulk_get_all(dev, &clks);
>        if (num < 0)
>                return dev_err_probe(dev, num, "Failed to get clocks\n");
> 
>        if (num != chip->npwm)
>                return dev_err_probe(dev, -EINVAL,
>                                     "expected %u clocks, got %d\n",
>                                     chip->npwm, num);
> 
>        for (i = 0; i < chip->npwm; i++)
>                meson->channels[i].clk = clks[i].clk;
> 
>        return 0;
>   }
> 
> chip->npwm is usable here because devm_pwmchip_alloc() fills it in probe
> before channels_init() runs, so one function covers npwm = 2 and npwm = 1
> with no variant-specific code, and meson_pwm_s4_put_clk() goes away with
> it. A future variant would then only need its .npwm value.
> 
> The count check is worth keeping: of_clk_get(np, i) currently fails probe
> with a clear message when the DT node has fewer clocks than expected,
> while devm_clk_bulk_get_all() would simply return fewer clocks and leave
> channels[i].clk NULL. As clk_prepare_enable(NULL) succeeds and
> clk_round_rate(NULL, ...) returns 0, the problem would only surface later
> in .apply() as a confusing "invalid source clock frequency". The check
> just preserves the diagnostic you have today.
> 
> There is a similar use of this API, count check included, in
> drivers/pmdomain/amlogic/meson-ee-pwrc.c, in case it is useful as a
> reference.
> 
> Since this touches the existing S4 path, it would probably be easier to
> review split up, roughly:
> 
>     1. dt-bindings (unchanged, keeps its Reviewed-by tags)
>     2. pwm: meson: make the PWM count driver data -- add .npwm, fill the
>        existing entries, use it in probe, and switch the loop in
>        meson_pwm_init_clocks_meson8b() to chip->npwm. No functional change.
>     3. pwm: meson: get per-channel clocks with devm_clk_bulk_get_all() --
>        convert and rename meson_pwm_init_channels_s4(), drop
>        meson_pwm_s4_put_clk(). No functional change.
>     4. pwm: meson: Add support for Amlogic S7 -- reduced to pwm_s7_data
>        with .npwm = 1 and the of_device_id entry.
> 
> That is clearly more work than what you have, so please do push back if
> you think it is not worth it for this series. And if you are keeping a
> separate function on purpose because devm_clk_get() is where you would
> like the driver to head, that is a perfectly good answer too -- I may
> well be missing context here.
> 

Will do.

>> @@ -530,6 +543,7 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>        .parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>        .channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +     .npwm = MESON_NUM_PWMS,
> I suggest use "2" instead of "MESON_NUM_PWMS"
> 

Will do.

>> @@ -642,7 +672,11 @@ static const struct of_device_id meson_pwm_matches[] = {
>>                .compatible = "amlogic,meson-s4-pwm",
>>                .data = &pwm_s4_data
>>        },
>> -     {},
>> +     {
>> +             .compatible = "amlogic,s7-pwm",
>> +             .data = &pwm_s7_data
>> +     },
>> +     { }
> Small nit: changing the sentinel from "{}," to "{ }" is unrelated to
> adding S7 support. Patches tend to be easier to review when they carry only
> the functional change, so would you mind dropping it, or splitting it into
> its own trivial cleanup?

Will add commit msg fot this change.

> 
> --
> Alexandre Mergnat<amergnat@baylibre.com>
