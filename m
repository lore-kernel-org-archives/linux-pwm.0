Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792482641;
	b=uMNyVTx66CH+YnQOO6gvU11NdIO/R8TabCDNGzetjijYqKMKUOUo1AFHKxIqTZ3qlqW4
	 zyln0syFbvFGSoPRtrutPFYA5LfWAC0KYdF8o/lwiI08nUXhmLDhLhnsFJ2eyuaQryeZX
	 w8vLbP62Stdi7v3G0WsaMhdEtmzTcNKbUMdxAXlEqIX7nw9k7qm2K3sHLSsTVTHB7sdSg
	 t359iJdpqrH3J5bjiP5ZV8ksCVoKqbqnD0Ryf1scGUfHueu8MeY10+nPcMbymkGazC8yV
	 NvmJOq8DfX7+G2mrjhnHKHkt/+G22iiWLgpqE7jGDzcGymorzMZ5F7ZY7kj+YDUiHKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482641;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IZZnKyPa7HLJF5KG2VLB64dHnszxJhX9zYvk+lCAo7I=;
	b=d66YFsvyPxvuvhQSbS9jbI7zYyz/0TPH66iEf6xSV0jEIwUfd2i37D31UQCA90K+88na
	 eaZvNuCDQObYU4k1xik4eXvTPD6BBe9aYBsV28OIZJ9i35CuUGDXTigDKnvlBElxDbyie
	 oCTGjY6s2JGH7SdAAhQqaBPKIuV4HipQRy319s1VPyCJKytNWUfvZUJhZh7AfpeUTQqEe
	 mCNvXSMlZgMHdPydHKcAR1eiiLDDgHGeVu0P27cmfiOsFgC9sALf2MIcMpIYDsbWYHKOM
	 ocpCyotccHl0vedkXGbLLo/EGeyQBc3+cJRLWlX1/prELyqG4G63iaQq3xuAPK62TAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ifw6gUM6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.56
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A8606A31C;
	Tue, 20 Oct 2026 07:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B6A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ifw6gUM6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB3uxZFjhcw1lZKuzp8FzM6o92VASW8DRMi378ZxIYOis7sLtyPCXrRN1IiSAa/bgOLc8DDx5EDFZzk05k77TQdPb1oovVUE6ukRvdGsOquS2NM2g9GPVLkdiS36Jty0QAuDEmxvgy9cLwMQIu9rIZW94S6s/6m6mz4KUZuKcAwWzIcHxEuw76vy8YN4S83n6K/YOXMWhgjdW4TUh5lZxTrfqoA6NBD3gJfDMd/7Y76BFqJg/pS0PicrTVTDYFHUsJj3LFwicJHQc/6lyLAbE7JhWZffrJU+dgj1AGe2CAEIV5wQOM8mG25l8Smj6nx0n6at3TwXlCYOgwRO/FfWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZZnKyPa7HLJF5KG2VLB64dHnszxJhX9zYvk+lCAo7I=;
 b=P8D+qnAh7ZoXdm4GksQyHAM1dLMPZaS6azhPhEoz4MrKVJpWiOc5f1cgFrjYgPdVCOD2/i2b733H/qljPUna1SGbRz0JJpdlAOOwfQN3lE8/ap67Egp9lVkfftnj4fBG++NcdAdPz1TEvhwi4udTGcFKoQyijMW/1xNuqne1p2A6Vc6csSyPKVnKJ1rf5HarNX3Vm9gER//nhIH57XFmKCEcjBgV20tROUXV/esu7hmMKsxwaIzGtEj8rg9t1Hs4xvyS/MCRz8WQs4xs0ThXpSgMi+HovHkRQTTzb92awvaz9R5L9XH4BJvt1CdqgU1gGeQTopcfqxUGvXGNjgrP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZZnKyPa7HLJF5KG2VLB64dHnszxJhX9zYvk+lCAo7I=;
 b=Ifw6gUM6mdJm/yePvfxauKWmbBaZCHo2TEl7hD/mkfEJHXCz5rDiOQ/NJEsHF0mRPOvqEyPmP5EVo88QXUPgEr+jkwym+bXzSrIqVeDnByqz+QI5bgLumE2kWeZEruYFbAQES/QpBAINhBk8PAlIZNN8muoHhZwQwb8HqR5KGuLwDFpHXOacsZZFRbfPjZOV9zBc8bIE0CAlLOigio2/lk2xabQDRIPiVg1wzO3675tDwiTp+1fNn2MdjCZf4qk3Ek+8OkvXDh0rWZl3rRHbRsxig/p7sQr4HQZWFmksq+WrHynaQNcTcLuwrwZzu4wiTQA9ArHhWuNXvZUE7A+5Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 07:50:38 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:50:38 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] pwm: tegra: Fix value discarding for duty and period
Date: Tue, 20 Oct 2026 16:50:34 +0900
Message-ID: <NYQDQXZBQCm1uL6pMDxwQg@nvidia.com>
In-Reply-To: <20261015085336.4181137-2-u.kleine-koenig@baylibre.com>
References: <20261015085336.4181137-2-u.kleine-koenig@baylibre.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: fc12b8ff-6882-470e-f2d4-08df2e7ed4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|11063799006|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7ATH7cKDWTI0jcHmC+vAM31fXDgQy/DEXlWBLaZjOY/j65BBGtptb6lLFwPGVd4v+brrs8Xk2vhRqrl5gP8frnNy2rmxg8GbrfAA7XiR+E74AowoWMh5qmhY2nhqaSIm7XnvyAcSbR1bMlhGP2xoVI4VNwHnVFjTqwZ9y1sbvj1hv1uIALvGAO2yWEGAmFt6jnvfuickfeI8jF9AWiMP1ynPc/zNVzeHghlEDxw7XDXQxgwBEHC8MQjO1CWHznjHVc+53IP9nqYtPDN0PiwdHVWCoSFR5moYdl5Dtz23TwEQNWhRkvff3a0dEJE/wNhJCOHlpcAMzg++GQZAL771l6jQP9ytC93AQXg+ly4Z3z99q2KRZjNgHD5jBvfQT6TN9/zWi0GpE3YQv5YGVJ5WcIV7e7ApfEVvp/Ss3LW+UOnPn+yzfbpLA72EcOpEbVsigpBd8C8yudglEG1yvvnvYFiy/hW8cTWNIM8sErO3vTCXp+hhU4tjlnk014QfDqI03miX8Ojor833VV64/t/86Yvq0ox097+X3/l0+Na4BDkbGNy/MfuvMIb3yF46XNn7v3Ol1HgNnps+DbvMrifacX6hs5CUZk0BRVFrKLl1hzen8QPH+H1AMEOL41tUnF9YfrFFdY+t7mlIxODx3iP50FpGGMOnVcxnWGnf36yvA4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHFQSVpNb3JXY2FoeEhNNlJqZ1RUTUs2R0lnL3lkMnBFTnBlZHN3VUVUbHZG?=
 =?utf-8?B?cUVvVXFWZldEMzdHaWJUTzZVdExvbFlrRmlHZXhJQWFSZXhHZ3J0OGRjOUZ4?=
 =?utf-8?B?VERVWWV1dldEaDVDVUxwOFlNclM2MGk5OUY4YlYwT2RBMUVqK0JFS1NvbktN?=
 =?utf-8?B?Q3FscHRzR21IMGZYNmdEL2hWRFJ5OHZtSDhkUExxWGJwZkJDM2F0Ynl2a1Qy?=
 =?utf-8?B?b2FOZWh5eFhicmZObFNXMUNaN1liR0d2N1R6clVEMElnR3M1N3pxZTM4MDNQ?=
 =?utf-8?B?WHN1eWlvaWtmOERueU5iam92c2tGOUpsTyt1Y3ZDYTdYTlVrbDZrZnovUlVP?=
 =?utf-8?B?TWtIbnVOYnZORGhtT1doeVFKMDNxcjQ5SVdRd0VHdDFmWE1WRTRIcVF1bnZE?=
 =?utf-8?B?ckJ4eTZsMitnU3hPeXJsczd5WmlpQnUvNVR0UXRRUnJ1YzFBZk1hSy9zNjRm?=
 =?utf-8?B?VG94MlJPKzNZUjgyMkRjU1B4dGJsNThMVmNWVG9lMnNmSjJPVFBoTFFjTHEz?=
 =?utf-8?B?VGdqMWFsVGxCVnF0VFdVNkswS2pyUUwzRzRhR3ByRllHZHdabkNYbW92bytm?=
 =?utf-8?B?dW04ZW1xMHN3NTlGTUpGczRvaUtMWE1hMWdzREFDYmMyb1FZOXVVRW9LcDJK?=
 =?utf-8?B?aWZVNk01eUQzem9FTzV1UjVDcVdpTUN2MytDRDNteTRpVHVkZkswR2o4VFdr?=
 =?utf-8?B?dU8xZnZMSmUrWWFFTSt3UlhLRGNXanlsQTdHODl1S252RUR1bktEaEJGUjYv?=
 =?utf-8?B?amt1QjVpaDdaSlcraG56WXptbHVnZ3BkZkVCLzhzd3MwTDFYSkhYMFg0NUNP?=
 =?utf-8?B?Qm9HWWsyRXF3eTJBemw5TlFrandVc29YSDVLMnpIRzNpWFkrUmhrNHlUNDdE?=
 =?utf-8?B?SHI1SVVldFphUXdaOXNhMEdFQXJrUWlXY2hzQVp2SlZVeCtrYVBPSTRmK054?=
 =?utf-8?B?cGQxTndxMFhTQXR4Rjc4eXpEUXl4MDJnRnVFS1dycUpJaTg3a1pWSHR4K0VY?=
 =?utf-8?B?aGJ4OENxZWdpUVJVaU5BempyQ0VDZEFzZ09EejlZRkxFRVZLUkl2b05xZml3?=
 =?utf-8?B?QUcwQWlBeTFwZlRSK3hjQ3VGSk5pYlk0WHBxY1BBQWJRTkh6WU9ZRUlLdmNT?=
 =?utf-8?B?aDJaMmQxU29RYVFrU21BWWxHeGlaTHdKZWJEN21XRjllVXdrL3dleHlEUUN6?=
 =?utf-8?B?VTZIZi9nTnZDdUY5OWhJTGlwNG9WVGRxVXF4SE9UN0lzS2JkTWhBQko1c25a?=
 =?utf-8?B?YmF5dDRaamQ0K2ZXMHZWeTlNbG5HdnNWcWVGNnk0UitZZ0ZBSG1NWnQ3WmZo?=
 =?utf-8?B?SUxjY1g3cHhSZWVvSkdQcmtFbytEeUxKUEZnVmxIaFhSejVJcmVaVDc4Rzhp?=
 =?utf-8?B?cjIydDgrMy93aU1USEFKSTZOMnZSWlUwa05MV1hIdjBZVU9VMVB1NVZlRmxr?=
 =?utf-8?B?c3BCdDdzWTdPTFpMQzZTTENhTTlQRXJBMjQ4ZkRvaVY1dTUrdTE2ZGtIZDV0?=
 =?utf-8?B?cndJQ3Qwdm90ZzlWWTFqMVp6K3dDb1pJV1gzRTVzSjNLU3FRS1ltNG5vOUgw?=
 =?utf-8?B?bFRDdVZqU2FxdkowbWZvcEhEcHFjUWVVQUNReG11RUVHRCtnTkVweVJSRUl3?=
 =?utf-8?B?bXpJRVhCN0R3VXViVitTQnBLZDNtWkgwYzFBNWd2c25VV2h6ZktiNUU3WEdj?=
 =?utf-8?B?TzhMM0RVYTF4MXNZQm14VHpuODdyMVdUZFh2NllPQTRobHNFTkpsbUpZZldG?=
 =?utf-8?B?OFZUVGdmaDlNazM1TlNUS2l4U1dIU1lmMmMrV1NGL25FOG5JZFZ6QTcwMmRP?=
 =?utf-8?B?YjlIc3pZR2wySW9Nd09XTThEcGlVckZ4ZGRZc3RuM3plZU9Cd1lXMnhGVWlH?=
 =?utf-8?B?cThwQTByQnhiQ3JNOERmbHNZWkd5MFlvRmViY3hVMitvMU9oUkp0bjFKR29n?=
 =?utf-8?B?L0cveDV4T3JMU1VJQkNUZWl6RmdGQWdiUnBHQ2JleDNlbCtQZzYzSVhtdFEv?=
 =?utf-8?B?bmFKcWhWbVNRTFMxTDdPWkVLeTA5K1NEUW5OSitmMUlFTEoxZHgyemRGRDdD?=
 =?utf-8?B?eTFJZU0vRTdLcTQ0dlcwT1NYUEdFb1ZoSk4vQXI1QWxrTG1iVkJmNkJLc1FM?=
 =?utf-8?B?WkdvM1BoWmdqNlZQZ3Y5TEhrNVhJNjZ1UEs4R25Iay9zMlFYTGc5TWJWR2c0?=
 =?utf-8?B?SEdjUFZsK2U2M0ZENkRsUmxSN2crTmJRd2ZlS2JXVU92RjlHUnFHMmsxb2M0?=
 =?utf-8?B?LzJoUGJTTmFhT25ydU5mcXdDYlk3cFdHVCtyU0FmY3ZkbWUwTVpXRmVKYVh6?=
 =?utf-8?B?NEZ6NW51Y0UyRVYxcmczanJvRDZqb0R1Q3RJRDVMcGJoaWJmZ1lUNDBFeVZw?=
 =?utf-8?Q?2kLMN/3pjgOu0SbmIpPBYDlATvA8CqZiYogMcRhNsY/FG?=
X-MS-Exchange-AntiSpam-MessageData-1: 2ATPfkKl7HrL6g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc12b8ff-6882-470e-f2d4-08df2e7ed4db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:50:38.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SCySK+xgSXe+VOoEnWoJKEm8YWmPKOUpFq3UBaz6D561INfOvC1PVkE7TfBudMvb1gn4Ci6s7LQQ0S4ioCetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

On Thursday, October 15, 2026 5:53=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> tegra_pwm_config() is called with u64 values passed for duty_ns and
> period_ns in tegra_pwm_apply(). Make these parameters u64 instead of int
> to not lose the upper bits for bigger values. If such a discard happens
> the values that are written to hardware become wrong, or (if the
> discarded period value becomes 0) a division by zero happens.
>=20
> Adapt the math functions accordingly to not let the now potentially
> bigger values result in overflows.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd83=
2
> Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> actually the Fixes: line isn't quite accurate. The problem that the
> arguments are cropped to int from u64 exists since v4.7-rc1 (commit
> 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates"))
> in the pwm core, but the blamed commit above is the commit where this
> problem was moved to the pwm-tegra driver and thus it's fixable there.
> The problem in the core doesn't exist any more since commit 0829c35dc534
> ("pwm: Drop support for legacy drivers") in v6.0-rc1.
>=20
> Note this patch changes the rounding of the duty cycle (from somewhat
> round closest to somewhat round down). It would not be hard to keep the
> behaviour by introducing a variant of mul_u64_u64_div_u64() that rounds
> closest, but the rounding is spoiled anyhow by later rounding of the
> period. To actually fix that it would be best to convert the driver to
> the waveform callbacks.
>=20
> Example calculation: Let's assume an input clock (pc->clk_rate) of
> 100000 Hz and a request with period_ns =3D 230399744 and
> duty_ns =3D 128249857. To translate that into register settings the
> DUTY_SHIFT values will be round down with both approaches and result in
> an actual duty_cycle of 127658000 ns (=CE=94 =3D -591857 ns) while 128557=
000 ns
> (=CE=94 =3D 307143 ns) would also be possible.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-tegra.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120ba2d..8b5ed7998fdd 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -138,22 +138,21 @@ static inline void tegra_pwm_writel(struct pwm_devi=
ce *pwm, unsigned int offset,
>  }
> =20
>  static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    int duty_ns, int period_ns)
> +			    u64 duty_ns, u64 period_ns)
>  {
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> -	unsigned long long c =3D duty_ns;
>  	unsigned long rate, required_clk_rate;
>  	u32 val =3D 0;
>  	int err;
> +	u64 c;
> =20
>  	/*
>  	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
> -	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
> -	 * nearest integer during division.
> +	 * per TEGRA_PWM_DEPTH cycles.
>  	 */
> -	c *=3D TEGRA_PWM_DEPTH;
> -	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
> +	c =3D mul_u64_u64_div_u64(duty_ns, TEGRA_PWM_DEPTH, period_ns);
> =20
> +	/* The cast here is fine as c <=3D TEGRA_PWM_DEPTH */
>  	val =3D (u32)c << TEGRA_PWM_DUTY_SHIFT;

The change looks good to me, but the required clock rate calculation=20
further below should also be updated accordingly.

Thanks
Mikko

> =20
>  	/*
>=20
> base-commit: 00e917df050d79ac26ec700717680ad6421d2808
> --=20
> 2.56.0.rc1
>=20
>=20




