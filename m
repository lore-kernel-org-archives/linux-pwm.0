Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020112.outbound.protection.outlook.com [52.101.193.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4248125B;
	Wed, 23 Sep 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159175; cv=fail; b=mVhxO65nJ9nEG7nbVJHSnZE0rEejbX/FgPXKQbnn0iLBl7RB+jJ6DEcuxPCG5Odz3rgxdKtwCP01o5u7dycJASjx+Dtgtf9rIoxh2o0mDYf7kaDmKGdUJiHibhuMUrqg0EvQt89uK/Z5bxA8xR6w5R9iXYRDjpy5LQ7uyoZqBL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159175; c=relaxed/simple;
	bh=XPh2wuVOdQIrvUrQbhILg3+ruve7+5YjOow1rY9hmfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUmPl4WjMR6XA8suyBt5fr/+9eV9hS4j5E44haBshglZ0y78/yPcjEXK1dig6CCTDA5bdv52U0zUkRTOwIas1O+c5UJ+qBQ2yGXl8R0R1ai9CxVWOdqDFbCgWKPy1pvFHlJVL6yzxTibUnzDKfdZJCQr7TTpygUBOi/U+P8Dtnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=peCrqTfv; arc=fail smtp.client-ip=52.101.193.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="peCrqTfv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAwb0IYFjY6JUrp7pd3jspoU5EC6EWhiSYsn4VxwdMtdSAbo7QkmgIT7wIql5srnjGFEZwv/NXOZPr71Ww7h8yTum8uqa4U0G3mswfpxSuDMlYjh5GKwGxByjmu647UYXcAjSwnsZi8Am2n6AZsMVPFgW6v7unSXlvIL1iwRE85/0f6WFiUb5CRoPVtf5UQ6mpWx4dmP4vFPa9xfjwwBVbquLi0XJki0ScVYHn2H44PLbcx/FXV45WfqAu5+adKFYg5co3zgZHgVWasuKnHptps3Sb/X6xsEiM2z3gaTzxJsLdeF6Pj6q3uz3doNxRLxiYCPQRCC32wLk1bWS9fxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efvDDmFd0U8WBzJlviu8phus6moO634rZNL/3W/1XFk=;
 b=CnEwCFvWbvg8/rzvJiYQRkdMncRlwM4JfEmC/vOpQbCgkGraOGWDhRHdj3aFIn01p5fwzqZx0rZXlhgoPBnl10tYuOQ9o9Sc6fxQiEftfglGDA5OE5xe4ZA+/vjkMa472AaUB+HIYvzjQUGqGzdzXyab8F9H42iyRfcuduLBq7ADdfebuTiil1OB5x2Omn8eij9sGFV342OTr9fy0oFyGiiX8tMgNPgOAIwXhakLQpRjcCPj2b6hyGNT2ezcos+KtWK0MSzdo/tgXeMBWF885KDsu3oejkYOtLLznUaWdAKCtIKcFqdGRq0uJrM0HfQjP9cExVO9JUZEJ6M9u8BARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efvDDmFd0U8WBzJlviu8phus6moO634rZNL/3W/1XFk=;
 b=peCrqTfvM8fvlW/v7Ow44tuXcT9VTp0JYhvl2N61bICrzeyK0jjgwEnC4XJHphPwMpoDCwUc23SBm8dZMf1CXRWjTNvsTXaCdw6q9vHfun13vLObmRED07wol7zp8tSBkpRtOlFFuKVuMNVllqqGDiFDKU6VKhMf5kgWWZOFvPJE1V65OnL7jEBbQmDl5TPhtuvhEGet9PY6zUeECwXXk8o81LYIep0dnfuYcoFDhAeLSkWsPZIsJyxbuA01Ubjzs/8mSmSjN33BzxYJgXUV78Zr/kNFYvQbHWIbK5PZPOTLbyeQxkCsiLBysHqg42zanwjlEZN2i5kW+cpOyBi9/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 DS7PR18MB6387.namprd18.prod.outlook.com (2603:10b6:8:255::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Wed, 23 Sep 2026 10:25:57 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 10:25:57 +0000
Message-ID: <654a7c50-86f1-489f-9542-f77d63550ea4@axiado.com>
Date: Wed, 23 Sep 2026 12:25:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260921-axiado-ax3000-pwm-v5-0-202aad28e129@axiado.com>
 <20260921-axiado-ax3000-pwm-v5-1-202aad28e129@axiado.com>
 <arFAj7yU2x42-76G@monoceros>
Content-Language: en-GB
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <arFAj7yU2x42-76G@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|DS7PR18MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e2556a-19b6-4848-5d9d-08df195d0e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JO1lhFdkbUnDj5wDUBmmCBliVHhjusyrb69zLpV55IOjrSHTQpl1SJ96NmgGHaxdobTBE5R9sKmBQ11B2Mz5kS7Bssg85PoxdjkErwIcCJJrtdqlSkuxTG1VNc+tQRsHSHm+B/9mEdRAkIsvlt+sfLL5MUtxjPrAxYhnjnIhjg84s+fPUuHqvHl0RBbqz/y6cPmK2tNOI7vx3YuN49N6wKEa/leGf2A30j5V4spJS7DrEn4ZbdY1ni5kmGFMTaqEPKwyxWNd7b50iPzuutQrb1SQ3uAe/ZKbz5Xo4/aWPDwhMreNBl3ZN1GI1TQi/wsdGsObzjZYBtRIHLHYbsJSOiPor4VLffVtZcm+U150YPmPhhopmlAP0E2lcDhfYuo4/WO/W9+taDB57TNep3Xc75Tfc8Y0hC7b1Nh9n67CF/x4vCSv09jDd+geDur1KyVJ/8qVNFWdWfFXh8ModhH8r1idkkSQyjZCqL4bjcpNiRdPhqlUe4spo0Hh3+FJmTVEvOE/4qBDdmrEEGS7BM+/TWIjLvezT+coJhOm8EYscf9MXnw1KpypcFjME2YVtNKIo23SA1M9LJO59Xr7G+4+jpvy3c2gZVBCftefthemRYB+A7GmkyPdNxE8PxeifMDnKjVqNWOu+Tq1bnECfzHhrKvfg/MVkfYPCIg/V9qGuLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGUrTUpURFpLdEd2TGxHZ2tlTUZGb1pyaWp4K1hqUWhQNlJuUHkyZVhzNktU?=
 =?utf-8?B?dXAvV0dTRG12Q2phclB5UENkUUtNR3l4NU5ETTk2RjI1TDc2SVM1Q2txcWI0?=
 =?utf-8?B?OXlxUk1acjVXSVlPa3BVazZ5RWFtY3JyVlBzMFVEby9ZSTBTRW1DUW5rKzBJ?=
 =?utf-8?B?bVZGdDZxTXRLdWllUVdOcW1TWVVldGNFVzNGVHJoODdDeGFVeHpvZTdxZTVm?=
 =?utf-8?B?WFV1Y2ltNkxJRXZOWFh2VzN3QkxiQ21waUU0azd0WDc2MjFTTllZUFpaK2VH?=
 =?utf-8?B?MEFnL2dCSVRJcTVwZW51Nlk2ekdhOWpQVysxcWkzUTNBSklMYTkvRTdyc3dK?=
 =?utf-8?B?bXhaM0FzN093cnhUelY0NzlrNmZLa2t5a1dGbGdWSXVpdlF2ZEMxcm0wVmF1?=
 =?utf-8?B?N29xOTAvQ2VvMW4vTXhrUktpWHp2VVdSK2hMRHZHdTZGaU1GMlArRGoxVFA5?=
 =?utf-8?B?Zm13U0drMFd5UHFhUUVrTGFranlabndXSDVObnRjZDdvbGM5OTJhZEE1emYv?=
 =?utf-8?B?VVlGUmRsUGplVU40NlcwNEc4RWNyZjZvOTM3NnliaytKVHNjNEo4RDk2cHMz?=
 =?utf-8?B?QlU1dVFNczFOY2hXcjUrVlV4ZlFBaHZJV3N4K0lxVkh0TCtlcDNTTFA2R2t6?=
 =?utf-8?B?bmlXaWRiYWcvOW9mNFpISldTaXRHOUpHSDUxbVBwQXE2NG1kRWJEbCtBaGVR?=
 =?utf-8?B?YWRSRXVubFdiRWFLYVdYWTVIMGxrTTRlNi92YzN3RkJqNGp4d0VVS0VlQ3Ev?=
 =?utf-8?B?d3FTN3VoUUZKVzk1Y05Sa3psVzNjMXhoa3lLa2Rnc1lKMUprWmVIdERJL1V4?=
 =?utf-8?B?OXNIV3U5VkVWNG9Oa2VtekcvWFdTc29ObGpHa1ZrZkluckVYV0lWczBVdFdu?=
 =?utf-8?B?U2J5M25ocTBQUktqYkpZZmxhbnV5UVhDdEw1UHdoaUNJTVJ3aVlYR1llTHhU?=
 =?utf-8?B?ZkVXRlhBL2ZXZ2duT1FIQlJQNVdKM3RrRXh0dFBUaVgzcnR0aTFvK3dFb0pJ?=
 =?utf-8?B?MENqNGRyNjg3R2ZZMnNhdXNsYWd5UklvR0QwMEp6dnlNQ3VtZ0RsS1UyYTE2?=
 =?utf-8?B?Zjh6VEFKQzZydGxUdlhsQzZZWFRIbDJ2TXNKdzREd0NNRng3a2laaEQ3UWJJ?=
 =?utf-8?B?NC9HTThrQWYvZ0RSdUxRRVVaUlZUQXh3Sk1rRW9xNlhjYVRPODNWLy9yczJl?=
 =?utf-8?B?R3p2Q1p6bjhXanJ1YnlJYTYyVUlFditZTXdwQ1J0RWlWNExBYjR1cmNYWkY5?=
 =?utf-8?B?aGtjWGpsaDN2SVZQSGYya3pvMWNmSEhEbGJOTUx5RHcyZ1JsS3k4RGNidFlC?=
 =?utf-8?B?T2JZeVB5M2hEMjhsZkFIb0dKZDN0NjdEK2tmc0ZpL0tDalMzaDI1VjU0aXpa?=
 =?utf-8?B?ZFVEZUlUYmVIcWtWSVlOK1Q2cG5jY2dXS1cwWWw5UXFIQXRVeVpqNTl5WWw2?=
 =?utf-8?B?d3R1dnd0R3VVMnp4Mm1lenNmT2dsMzhvdE1mbDVGNytBREtEdnRSWVE0RmZ4?=
 =?utf-8?B?YlR1ZFk5bUVXZ25zQ2M3YlVIaWpuVVZUVFRxQ0s4YVZOdHJkbFZjZ2ZBV3By?=
 =?utf-8?B?aVNVV0FaUVdONzNtaEJqcGhKcjRKSDVOZUljZXNROXM1YVpTV1JTSXNuSDV1?=
 =?utf-8?B?N05aV0h1VGZEN0hIbldJUTFhOFJ2RDI3SmtpRmZMQjQ0S1dHNG1LVkZETjN1?=
 =?utf-8?B?ZVkycXhuSEYxS0U3elg4SmVKT3FZQ0tzM1RWR1BCYlZVZU5pQUV1QW9PR0pk?=
 =?utf-8?B?djFyakU4OHcrQ09NUWhLdnJ6Vm5GR3lST2VEUXdOQkE3MkZGRURZYlNVRWVq?=
 =?utf-8?B?WStBWUYrWFExbERTdG5IMG0yVlkxNHlDVlE5SVBsMlJtSmlvaWt2d1YzZFhK?=
 =?utf-8?B?VnBrWXVGQndnRmZoZEJrdkd1Y0xNMXpidE5zYjVOQ0RSQWdUeWI3UDhSR1Qw?=
 =?utf-8?B?LzRYdFJUblpLU0tNR25NWkVkam56eUViYXZRa0tvcmhvT0NYSTZHN1JZUk5n?=
 =?utf-8?B?NllHdmx0TjVWcjJwNytYSnRxWUtuWjQ5ekxtaW4zdmliMVcwZmZoWEllNnov?=
 =?utf-8?B?WnlJOVR0OHZ0aFJhQ3djeUV1Q0VFZTNNSlpZWXkweVRKVkxkSktPQTBRVENK?=
 =?utf-8?B?dnJRZGs3QXRMSmFuMytjMHZNUG5INTlZdzJpSUthcm8vRGVFUlJta3NiZmhl?=
 =?utf-8?B?TVZTVXR5NnJoNnRrV05CNlpzRzBMNGllNWdVNkZqQ3REOEVON2lKVENEYnBi?=
 =?utf-8?B?NmMxbFAzeStmUXczU2c5M0lsR25LaWFlREhZRUlVbHBOMTBKbGdnT3Vvdk82?=
 =?utf-8?B?L3NmWlNiUTMwaUk2VDNzK1UwbjNXOHZQM2ZZRitNY0RLc0ptaFNldz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e2556a-19b6-4848-5d9d-08df195d0e6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:25:57.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R9S5JRpKWnouNXSsKetxAgYUxBdgTAacm4WVrMd5b4tRJQU/vpIduMXQGWV98vT0VbDaQB/tEqVcQkWn7BLnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR18MB6387


On 9/21/2026 4:35 PM, Uwe Kleine-König wrote:
> Hello Petar,
>
> On Mon, Sep 21, 2026 at 12:21:30AM -0700, Petar Stepanovic wrote:
>> +  "#pwm-cells":
>> +    const: 2
> Can you please make this 3?

Hello Uwe,

Sure, I’ll update |#pwm-cells|to 3 and adjust the DT example accordingly.

Best regards,
Petar

