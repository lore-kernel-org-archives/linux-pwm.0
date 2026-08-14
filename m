Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022094.outbound.protection.outlook.com [52.101.48.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478E40861C;
	Fri, 14 Aug 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691902; cv=fail; b=ZImKa/9i/frkSMOyHuaxrMupU9V+7g6BXvG0O1nHFVwv6k/y1P7wphevf5EmPCiUwWihylozKHbCfC8WrPL40Jpb7P4YYg3iqeSOxwhGVZDu5b9QdJ6gaqezzhSj5sJ75DqiLtgcGUdefvVvAW46Y1PeLD3g0tf9+QKjNw9x+CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691902; c=relaxed/simple;
	bh=KC+xGlRqNqmszGKy4p+t7J34z6e/3pgFNomy69gMkFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G5d+G4KOvw+vhllqN/Lx58YXxuGnBwcIZDjQHWcINBg/7FvX60GuCsS0MmZnOrbdF2tiNOXQYfIwitOMw0VX6+FxiFa0ZjrBM4I6m+eR26G943fqsXyaLZMyUjc4m+vmpgEDcE1UPxImeHexBZlhp2lMD14TUrqfUSyra1SVPdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=qjS6N7LD; arc=fail smtp.client-ip=52.101.48.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="qjS6N7LD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsTcms83Pvtk+vqwdRU0PGjcki+Oqlh6dTxyY5oMdOSiNcH2at97Gza7EcZJbGye5rs4CnrDyHI3yM9QN2h8qj2DDqSommQkfAhWRrbYzcOTIa5LKUnp5eRRM3RFmBMzyvHHeNmQ9RfALKPF1ZufCJaQ3ziUDZRPLgtXpTdJ/teWbWSMRXync3p3iMt+7MWxeana5Cjlv0gDyLJ5p6R4HySxslCXY8ngzWpBRz1RI4Po0uuT9S1gU0IGHE8EBA65U2dRwn0faVI3D0gXOSo64aTJrzcotGwXx/J1ruGAluZD2rTXzJnUkk51/Xl5Bde28OL7y+eTv0/FYs8GWSJQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN7madMarZWpnWu8DCZpqQiB8rMa6STvPZwYESJw72k=;
 b=IBUn5iqzpipFZjY7TiaGUFaFU5kU354YVM/PBpEhULRfJSz2U3dlyQN5hmWDdbFfGnJd+pzNjs+BcGZ8wOawK2ZBRL07ZiL0jD6WJHJBekX7tJjGqpk92SRcbL7rFraZLorkR+t+Q/HOSYbmmMxcT0wZU/6kFEgbYCDLpcOE6R3Re0h9+PpfJGfh5wKb8QB0uIVGVlHG2RvqNjAG/qHTKs64cEFekDnTtJPDQE1aqxIL4BHQX4W3g4b+C+yRz2e78xp5qeGr5Kq4foWWD64zli0+AcVG/9QYpSdewhq9EEGM3lG58zzZfikvGb14gk4GlH76phW4XHglnu1dsHA3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN7madMarZWpnWu8DCZpqQiB8rMa6STvPZwYESJw72k=;
 b=qjS6N7LDKvXvAn4RH2l1ZgGP9OnjAN5HequZxOHTmshTugpC1oET8UVJkcb51VCs5fQzFPNXt27uBY3eFmMQWOJEIKBr00qQBy89EHlf55JsWwv7RsQZWj/DnmTRHOmaHDV9iFLL2ysQRzwS1M2o51e+845hYE95EHo18aZ9XabD8rMI3J6zRfnBJgBmNt+JBLWv8JVluucfD6Bhgj2uzaVKD6GzxI8FIVo6NnCUn9iSIAwoHm/jV5gq0wNwbpRUcDT6jvtBGgQscawFqoyqM9/m9wGauB/pwDFSUkV9y2BbObU6xilojdE3oH3OS55r/9MF365KlxkCIRJ5Ejvg/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 DS4PPF8B721DA48.namprd18.prod.outlook.com (2603:10b6:f:fc00::aae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 07:18:17 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 07:18:17 +0000
Message-ID: <25314ace-34b6-4c4b-ace5-9d89ca01271a@axiado.com>
Date: Fri, 14 Aug 2026 09:18:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260811-axiado-ax3000-pwm-v3-0-6ceaccd812cf@axiado.com>
 <20260811-axiado-ax3000-pwm-v3-1-6ceaccd812cf@axiado.com>
 <20260812-fearless-antelope-of-might-cf3eff@quoll>
Content-Language: en-GB
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20260812-fearless-antelope-of-might-cf3eff@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0065.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::10) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|DS4PPF8B721DA48:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0edf00-b88c-4fed-601e-08def9d43647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ItMXf+qZhutK0SP/paCqdpeeIyJIjH4VcIl46eARruCfQ4KOkwXONALuM7izlNK1hwkuinq5lOB+/ittXonRmjUSQV0kqrmsr4rHSQ2jt9NcYlZh6KQCsnqKuw28p6jrtRvNyfOOq8ZyKrlk65mbeL16xQQpKHbfs8AFcrZaYs9y5Uj5LzVQB4i4dvtx+MB23P+wUxUuh8IzEQtGjCsx+taiNzc14wMfzD57bjdGRzwXRmW1RHok+69LyMy5terNuRerv+w2sTJAqTLQgdJtilAhm63hOsVXGe1LdOpLAKZjA5HcYb82j/DOW90PGjFSeQMfkdAMNQoVIJXx3InXSUdxylgMZgHWhSzTOmqkSffJpPbC/FK1FN1+4jin8jERY98vGkzbDOW9nD+RLBTcff2Frs/QuQLdtcMnsaOwjvm+pXcNZIAsE9UcfuD/cse5nURyZN6ck81RpmWBZ6JD0kNKmzhdmOWqduPNZepCgeLVyXJzgF6JeRcTJISM764MHUjsLkdLRy2yh3agDkQsa3SFUFdCELV9P+ydsGYjrSa36JsAIF0tgaHkAq5Slf0IpGOCylmJ4NojYt8C8cDoxBN5Fd90+c7ALogQbUre0kA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3diRzRBNVJIMDVaUzZZelZuU29pWTNOelY1cXQwbFNlVXFOSGFRa3UvWUgr?=
 =?utf-8?B?OVFVaE9ha1U0b1UzYWpadlRBTjc2Rk0zOVdGQm1RRm9GN2F0YUJGdXFGZFdS?=
 =?utf-8?B?L0Y2UkU2b080QzljVU00aHpqM3dsOXdzWVZFdlBwMThUeW1vNDFCcUZVbnhV?=
 =?utf-8?B?OG5lcUdENVRWeWkyZ1RQSVlJZTM0RGo0QXZBME1oZHV2ekQ2RUtIL0FOdUxH?=
 =?utf-8?B?TWU4eC9Lb3lYRVgrQW53dVlOUjAvR1JoUzZmNGhtd00weDFMMWgxSDROVjlR?=
 =?utf-8?B?Rnk5TVpPUE10Wk1xc281ZEdYRm1ZVnEwc09mR3k0NWRKcTJybnVHcmxvN0JT?=
 =?utf-8?B?MEhEdnlyUVFxcktRSUJtNFd4T2RMN25XNkE2ZEhjYm55aitrS3lYeVQ5SXJZ?=
 =?utf-8?B?SFMxZlMxZUo0Q3VUNFphQk4xNXFIWG53SW8xd3dGbzluYXlPQ2t2UnpOQW40?=
 =?utf-8?B?UEgrSEdoekZhN1ZMc1Q1MXE5dW51QjFpSXUrbkkwUm9VNnNTMHBXK004OXVY?=
 =?utf-8?B?akZWUHdIT1F5VGRWdU50NVVhZ1RjcDZiZHRJVzJVamJBOGJxTHY0YUhYdkkr?=
 =?utf-8?B?bHB2WXR6M0xaeTdTdVZGcWpwSzRHcXUxSG14QXdGZE1xN1ZzRkgwNlhlcWNQ?=
 =?utf-8?B?Y3hEN2xmQkZVSWVSTjhlaTgyeEd3UXliUDYwc1R5Wm9kd1hSQkt6NVZ2eXZ0?=
 =?utf-8?B?anJPSnhCdXhjZnczTjMwakZKR1UxK0puTFRNUHdKNWpjUHdManRMQWF3Y1dx?=
 =?utf-8?B?YVAzQTdFM0pZWHNSM3hDZ0JXVktMaHIwQkx4TDBoa2QrMyt0NDZhaURYTjFo?=
 =?utf-8?B?cWYyR2ErRUxXK1daWWZ1RnZFRWdTY2xCQnZTTnYreXJsRzRCKzR6c2NSODBF?=
 =?utf-8?B?anJ0bXpTQm1FQUJ0aWlMUGxvS1dvN0x1ZnJhSERoY2R1ZisyRk92SXlIZUtL?=
 =?utf-8?B?VXU0R0ltNGovMFFHRUI4cHdNOC83YjJkaFhSa1BtajJRcHNLMzVQOU43TnlJ?=
 =?utf-8?B?LzVLMkk3YkEzQXpxS1ZIQVdGMlNLdnZuZUN2RWxCdWRodmJSWnB2RlZoaDh1?=
 =?utf-8?B?ZTd5QWZHc3oyRG9qb1VvMWI0VmFCOGZXNGpzQjlMZXNrWm9mZlFDUzdnS1BU?=
 =?utf-8?B?U2dqSk9DOXFhMXg0RlhWaTI5OWRGQkNHUmNtSWFzNlB4Y1ZrR1BxS2hxaDNv?=
 =?utf-8?B?akRFdXoyZitJamVoKzJGaVlkYVFPV096NTRFOVd0Z1g2M3R1TE13SHFkaE8r?=
 =?utf-8?B?aU1sa0JKNFI2SWk5OUhJOWFGc3hTenByVHV5YlI4YUJvSzg0OWN3RU9lRUNh?=
 =?utf-8?B?cXI1L01GZ1F5djBUOC9hQ2hsVGY2NEJjRU5aVWxLTEd6QkRoVmplQ3p6bS9Z?=
 =?utf-8?B?azdLR0d2blViQ0pOUFFPUjlKZ2RBVHNlemZHd2JtRGNvcURwZmxZQnpLVGFW?=
 =?utf-8?B?VFpLMW1LVEFDaFlsWjR6RXd6SC84ZndrejZUSDhXcmJTN2VGcFVCRW5MU3pV?=
 =?utf-8?B?NVBMSlRzaWRNNmRoWjNZMVQrQUhYaHQ3VXVsTmhYWjVGM0hFbUVEcDMzSWdO?=
 =?utf-8?B?YW9nME1WN0Z1a3lVa2k4dk9VbE5KbXdsdnAzYXRBK0xBTUlmeTNTbHNGWU9B?=
 =?utf-8?B?Yml3alFWTzNMMXFEaCtDdldJamtlVVVJeVVPQ2Q5dlo5ZUw0dnpPeEhMYUkx?=
 =?utf-8?B?TTVaQ2FHSzVxSHlDZFNnN2hoZ056R2NNNEV0QlMyeHRQUjNqRXhuYkZFUFky?=
 =?utf-8?B?cUwyWnVQb2F6bk1ENFBUVU42NElsblBxTGNQejdFOC8rck1OYVJaYVcwUDRx?=
 =?utf-8?B?c0VRcjhicTdzMFBNRGlodDFHMHlTRnhXL2ZGNXJBRVBEN0FvdlZ3Tis0djNt?=
 =?utf-8?B?MkM5a0o1Z1FUdVprZ05VL2dEbjBHSFNVQWVhSGNXVmJvN0xrdERwUndwcDlM?=
 =?utf-8?B?MzJKWGtKZDgyejhwSTBJK3NiVE8wQU1yV2Y2eHhoeERSYmRmZjVNeDA5SG4v?=
 =?utf-8?B?UHlTdEpuYjczMTA0R3ZMUUhLUXQ1bzFxdjdaeG85eEFDRDVrQWFnd0liYVJZ?=
 =?utf-8?B?aGhKZTh3WXBRTHIzUURVUkNBM1Fvam9vL0pjbExTSFc2ZXE5WWlBV0N4d2tt?=
 =?utf-8?B?TThqcUdwbDE2clJSSWVCNkFUVlBEZmNCc2dGeW02TVhJWFFRTGtMNHFaNE84?=
 =?utf-8?B?Sk1jcnovU2FXZUdjbVdmSmgvOGhEUDlibDd0cXVnb1BEcWNKdHVuZDAzYmFI?=
 =?utf-8?B?RTFGSHhjR3NsTEhQdXRCWjRUQi9VWmdscnErd1RYSnlQZ05LUmxYRDQxWnNy?=
 =?utf-8?B?Z2Q1cmxOQnRqenh6L3hlQTI2d3htcGtpY3duN203SnRYOFBxZWcxUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0edf00-b88c-4fed-601e-08def9d43647
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:18:17.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho36GtEVMEnxAiTSMK0uYYObPSMpJFvvZr6J4NbUVv8inTdAL6iNUkXBZSIFqMhzXXDx3X0ZIHFSRZzxkaQcEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8B721DA48


On 8/12/2026 1:16 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 11, 2026 at 02:01:50AM -0700, Petar Stepanovic wrote:
>> The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
>> used to generate configurable PWM output signals.
>>
>> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
>> ---
>>  .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 53 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  8 ++++
>>  2 files changed, 61 insertions(+)
>>
> Where did you explain reason to drop the tag?
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state in the patch changelog
> or cover letter why and what changed.
> </form letter>

The tag was dropped because I changed the compatible schema after your
review to express AX3005 compatibility using the AX3000 fallback. I
described the binding change in the changelog, but I did not explicitly
state that this was the reason for dropping your Reviewed-by tag. I will
make that clear in the next version.

After checking your DTS101 presentation again, I found that my case is
better represented by the fallback-compatible example, where the more
specific compatible is followed by the fallback compatible.

The second AX3000 entry is a typo; it should be AX3005 followed by
AX3000 as the fallback. I will fix it and validate the DTS against the
updated binding.

So the resulting binding will be:

compatible:
oneOf:
   - const: axiado,ax3000-pwm
   - items:
       - const: axiado,ax3005-pwm
       - const: axiado,ax3000-pwm

>
>> diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
>> new file mode 100644
>> index 000000000000..7297abccbc24
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/axiado,ax3000-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Axiado AX3000 PWM controller
>> +
>> +maintainers:
>> +  - Petar Stepanovic <pstepanovic@axiado.com>
>> +  - Akhila Kavi <akavi@axiado.com>
>> +  - Prasad Bolisetty <pbolisetty@axiado.com>
>> +
>> +description:
>> +  The Axiado PWM controller found on the AX3000 and AX3005 SoCs.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: axiado,ax3000-pwm
>> +      - items:
>> +          - const: axiado,ax3000-pwm
> So 3000 is listed twice. You need to test your DTS.

Best regards,
Petar

