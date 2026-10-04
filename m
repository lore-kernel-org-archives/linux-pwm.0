Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52579B672;
	Sun,  4 Oct 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128032; cv=fail; b=ljify1337DOFWUuBJhmxw3B3CiQUbhfG5SnT5pmu92lMiXHwtph0/xgpC6wypUfpNBy10+uPNj4sAdKVj8PnuMA61Gjb4NsWuniqU6Mm/CZu6jXgWTF7oUDPDUn4/9v5PFRFpShR6epqLGpQ73pjBZH9K+Y5IEB/5PeWEDR01MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128032; c=relaxed/simple;
	bh=9gVwmCwTq7nR6z9L8msaFYlEIXdDcUNWhZVQWfhhUHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txqDepxJn4oGeYBXucoyM9/vffpCFYsQH/pNgvbY3idAGjbYoV5rBjk5XNhfgrmwXcdW5U4FzHi3Utiu5oXJTbYEwvMCCQ6ouZ+i4qch9lm5qgDtk89LapOJqI4Oo3LPY7MQD0jLrcgc0VfP0FSvBAHzVa69WpyXDN99uXAaQyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=curH4aGj; arc=fail smtp.client-ip=52.101.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="curH4aGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnZGeZOh0Ut6Rg89dBf+IexHclvo/INaVjNgfipp3V5zk5ujgHYjq9E3PI55NEFyEuaSw9eHQ+AZnN0wcoyQGKEudrbJ+IqvJdHOJj7b9Man6IJpJihEIzK91lA1XBc9CPQdDzF1nOuue7HRDyadMZM8t2VOR5WbzmOMjjQH1dgL16DyXcDa8nS3VeIaPYaqlphHgxizJorinizGZu3d8JjV6/gWNkzhL3WEqlzyjWE1thUU1996mSbWoLaUxkRseGbuuT5PjqMIroqQMag7kkmi6X6GVJKLOFg+fr+DqG6aGwhjxO4qS7aaI8dLgj8sJREocWclNsSa7OERRUAS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gVwmCwTq7nR6z9L8msaFYlEIXdDcUNWhZVQWfhhUHw=;
 b=xbYPh3FGkZvTjjG/0O2NVG6Caatcq3IjormBd3DK70+YPmWXr2YzLeNedDXBN9EAI0WxirJ+pEJh/HHDa5lkUHh/jF8k0RlRBgDjsnKyfiSVwrmud6JYEuuFzznk5+UgRprACurx/V1tv+etrYZCm80hFdLfoi0NGmQKT3A5vjQlWdrW2g0BHrE1IqxzPebbM9QEQYg78ViafnDEx2AfJoxxeFbGLBbkT334gz2PdFkAM+QD+9br6HlE+XK3r8fSFl1BV8vp+2TQ+LiOYOB9y/eFzrmA4FnAS/UADBTVqhqDf1rBxEglaWNuYapcZ035NV0Tw48Ded4xb0f6FYbJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gVwmCwTq7nR6z9L8msaFYlEIXdDcUNWhZVQWfhhUHw=;
 b=curH4aGj1wBhZ0M6MCDP/BakiLkGCUNX65oQFdGwRfb+Zczd2qjj7AlFL6evl4Xdc8sD4cXHNiBEHLz5cQP3OTL0SVuHbdJLvot2jle6qWoFyvJPopsLBsstu+i14y8n3xpmPQPt/viWfE4JbIgp9nFQldczh4OPYFPgRZoF3DBo4IjZi9GNU4kmuuB5SocnvwoedX5VBk77aCm51ZNIM+TU0LRMfs6lVX//P1U4uUBWsT+zH8LRb0qHijI8svsbmedvZkxDjtVuipKWP9PgrY5aHlw4RjyW3XYLsjT5mvkO5ycQKJ2gQD/80TMtvFQYC1cNnoMIRKgXBp1eJXjRfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Sun, 4 Oct 2026 15:33:46 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 15:33:45 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Date: Mon, 05 Oct 2026 00:33:14 +0900
Message-ID: <oG8AGa5CQQi_5H_Ter5mEA@nvidia.com>
In-Reply-To: <ar9vT4FY3QxEvRZH@monoceros>
References:
 <cover.1789741839.git.u.kleine-koenig@baylibre.com> <arzjXtZj0hIf5iZU@orome>
 <ar9vT4FY3QxEvRZH@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8eda05-ca4e-4d41-7a98-08df222ce0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2y2I8lyWmV9WbBBhdb3yhT0y2YQWMkFWFRMDgf/RTyaMSTbkUzuiUQHySNhBhJRZSoNNDpJ+lYsaw2FF+QlfUSrXwR+xI3DLyOqc9/W8O5bDp5ThLb2LD8j6ljNdYvPaF4X+alcIiOJ4hY1esH92YvDmLUipUiXZsuXBfQpguwy9fpLZnjtaBleTrzD0h5Grno9/f64Ran/RoFaSfq22yENxWAQJf8/7n7a4HJpE96p+1gvizlMJp0mFCvDlT9pUyEoPNmufOi4nQR+5/BqVbcSe6MJvCQcG0Naz4/OkLM/ke6jFDuqCXMvizE0J+/widOlj0nrtsMzzBEugh0xcGvTZ8xl9O9yOrg521HBQwBx8jtygRABtObdVJkROOc7zQN0s1ZBfa1I8mnyYuyo428Q3tzpdlq9HoZloauTVmNC7PRwgBwyaDPseTYUKW3QrpfW4d9lUZT/Km3o9flttuD6TIxxLyyWWG7DFBIOV6cc675/qWRCpngyfjeIBKn+V1cdgk9Qv0mqJsp2HTq2ibQriNBFW2+U/+Cdkv5pD89iFbYblX9WfZhQJ/N+m7VSCmnLz+/oBxoS4USKW8ErwVvZDLm1ykL6ZLeCFzUpDtkHGzrdNWJTZC/+vUpd0p85jYHDtQJ0iySDpS9qcid//USEPuSrnbfyuKeswrH8TH74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1RLb1ZPMlRzL3cxSE9leWZibTFIdkZTUFdnaW8rYTNGVVRPUzlHY2Q2M0wr?=
 =?utf-8?B?amJJcUZkZktSc3VrTXZCZ2RMcTJLcDBmOWpwcUptYk1WODZMYWIwaGdRRHdE?=
 =?utf-8?B?dU5ZZW9TRHh1OGRya0hjdnZRcVh0RUpzM3phUHVJYmRnU2hadFJDUXUzc2dT?=
 =?utf-8?B?RVR4UWhKT1ptU1NIdkNvZGFFb2JBS2ZFdFRPWHRXdmNtQi9QVDhGUVdkS1Vm?=
 =?utf-8?B?bXE2YXVNQlZaSVVrZHJGSy9RUktDRXZZKy85dDFHZVUzYzZuT3JSODFxcndx?=
 =?utf-8?B?ODJNUHFsYU5uMWZoQWZkTFdyWkRtWG43bjlQbXEwVXNYditDZFVtWVkrNWJi?=
 =?utf-8?B?eis2bHBZUVdoZG9Mc3ZYS3k2czJvbFJvVWRReE14MW5XNjlkSjVXdiswQ2xW?=
 =?utf-8?B?YldFR2NqK1UydDBKUGVNdHJSbFF6c25IRUtIdU1JR0VUUlV3elY3akoxWmV1?=
 =?utf-8?B?N3Y5V3FZYWl0SUdMZ1VodHQreGtjc1VzZEtxTHlkQ3JBaVRJb1RvbVlBTlcy?=
 =?utf-8?B?SkVqYWt6b2Q0TGcxQXUxb3dOc2ZmYlU3ZUQvYTZyZmg2a3UzdHNOcmNPazNN?=
 =?utf-8?B?WTNKVjFuMElCUFdKdktDNk9QbEErbTNaWGFucXhsYkJvMmVsMHRWRmoweGFY?=
 =?utf-8?B?QlJvMHE2K1JWcVRBbGdqMHJFQk90SXZVTUZlSDZZdkVObWlLOEl2Tkc5WkYy?=
 =?utf-8?B?TnlVTlJaZWxsWkM5aHpla3V1cVBzd0VyTGs3d0lSaFNkbzdBNGQxL3ozY0pl?=
 =?utf-8?B?M1pMbGFQN3UzVjdCUFE1dUxBclM5ejVCOUUzeTdRbThvVUVwSVlBcnlKVzIy?=
 =?utf-8?B?eXJ3OXJkbDUxVU9rZ0xLUmNaVjNna0puSkhXQXMrNzhXbUxyZzhNZUlGc0JP?=
 =?utf-8?B?T2UvcGtOUDNENytvUHowaVlaMzZiOVdrUjdpcWdkUmlUVDRkbkFrTGlvbllk?=
 =?utf-8?B?SUFrYkJmbmsyazJHcU5MRmFqQy9EZFJxWHJ3bytpNkxsTStlTVowSlZ4YjVO?=
 =?utf-8?B?VHJVWnMxaGhyem5peHJxcjZMci9odVExekpTdFhxc3BGb3Y5SlRuL0JGMXM2?=
 =?utf-8?B?VExodGVUdVBiL2JDOUQveGRmZHlhQlpUYnRLN29jYi9TcEtQRE9KNWV6QkZW?=
 =?utf-8?B?M3FUMmdMWEZVUzBybEI4bWpXcmJHb2tlWWx1bU9paUVhUE5lbUwrZm5WeE0y?=
 =?utf-8?B?RVJpbURYY2RzUDlRNGxZbXBQdGtPSVI4bkl2MUl6Z1RzUjhEVEw3emtWWDZ5?=
 =?utf-8?B?OStiV1QzdmdkT0dTTnJ3azJBNnJabytMU1Ruek9VMFYrLzJOdWpjRWZtK01Q?=
 =?utf-8?B?RnQvUVRLb1UrM2I5ZHA2QlpKa1JVSEFFclNMVGFrUFZwdGMrWmZ0WGJnR0N3?=
 =?utf-8?B?ZGlCbHNMcmxvL3d4N3pJSVErWEN1eFhIb0RoaHlQbHl2L2l5cCtScVQyek5r?=
 =?utf-8?B?eU0vMmVJdTVRWlNleEpKTGNjeDh0RDdEakxweWlOVlZ3YmlEdE5POWxSSWsw?=
 =?utf-8?B?TFpEZE9vbEtmK3EraFk2STU3bml1dzhkWTA3U0xXcWN6cGN1aHVpMzM0bGVa?=
 =?utf-8?B?RFczbENrMDNZQ2tQd3VvelVJSlVGV1BEay91bVl4TUlwS0NxMVVuNVZuVVdo?=
 =?utf-8?B?MEFVbUQzbmtadHVSOVNFczFJc2UxSWM0dzA2ZXpPZ1ZpNTZGd3pkQjNDMktW?=
 =?utf-8?B?bGRUR2xDdUpMSXFtakVVQS95WGlQYXlpZFRJNEplZnE3WkplWDJlL2NTYmdX?=
 =?utf-8?B?c3o0bFF0eDVMQ0ZUZ0V0Mms3ZFpGWXBGRGNlR29xdERhWExkSUxMd3B5VVpX?=
 =?utf-8?B?R1E5RlAxd0xtS0tpR0tIQi9HZ2VDVWRoNVVHWnNtRy80cXRUYVBtYkx0ZFlr?=
 =?utf-8?B?OVI4alJMRlZUSXhSdmNDRFJQeGswTHFDcFFRSUxKYSs3R2VKSjcwd2lLS2VH?=
 =?utf-8?B?dThQRmpjSWNvMW9tTnc0VGFlVmxvTUorZVgreDhMYmdSTlg5OTNiQVpIUXZs?=
 =?utf-8?B?eEloajhGTE1CbUhRK0ZRSTlsTGU2U1VRTXcwOXBMQ0Z1ejdBS2lHY3RMNlJ0?=
 =?utf-8?B?UHdIQWpFc1ZRMVpLVjFnN2F5R2pJME44ejY1Zm1sbEQ3SklFNm1wcXlWUjhZ?=
 =?utf-8?B?eTZIRlRQa2xwdzFIL1JQbnNGenMwZlVZWmx3eDB3L2Z6eTdpVlFCSXZ3MkZp?=
 =?utf-8?B?ZCtmVmFGVG9BT1A5dURrYllZeHVTK3l5YnpRSjE1UnNRZVg0TktZVm8wUllT?=
 =?utf-8?B?dFRlSGM1NmJLVFIxTUpGUndoWXpoUzZXL0poSWhLQkVlVTJkWDdncEVKdHRl?=
 =?utf-8?B?RnZZZWpRaTE4RUhhRVJVMWkveDB4WUlKaTNPcWVKcG1Yamw5dVZiZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8eda05-ca4e-4d41-7a98-08df222ce0ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 15:33:45.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRjqpUa/nMzyZBPpzpKA8nTk/asRkFHndcGdFt7sNU++SN6TBA25ZxJ8IZrHpZn4uCIL9Y7rnNBRUxjc1scnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

On Friday, October 2, 2026 5:51=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Sep 30, 2026 at 12:29:42PM +0200, Thierry Reding wrote:
> > On Wed, Sep 30, 2026 at 11:54:03AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Sep 22, 2026 at 12:07:26PM +0200, Thierry Reding wrote:
> > > > On Mon, Sep 21, 2026 at 04:26:03PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > As long as .apply() also hardcodes TEGRA_PWM_DEPTH, it's IMO fine=
 that
> > > > > .get_state() does so, too.
> > > >=20
> > > > Okay, fair enough.
> > >=20
> > > Is that an Ack then?
> >=20
> > I've been thinking about this some more and I don't know if it really
> > makes sense to keep hard-coding TEGRA_PWM_DEPTH.
>=20
> Full ack, ideally this implementation gap would be closed. Compared to
> implementing .get_state() I don't feel confident to do that without
> testing though. (Though I could make the driver return an error code if
> the register setting doesn't match.)
>=20
> > If only .apply() uses it, then it's mostly fine, I suppose, because we
> > don't care what the current (or initial) state is/was. So we either
> > don't use the device or we overwrite it with a custom set of values.
>=20
> I don't agree here. If the TEGRA_PWM_DEPTH setting is different in
> hardware than the driver assumes, I'd say .apply() being wrong is worse
> than .get_state() being wrong. So I'd either go with .get_state() as it
> is now, or rely on someone with hardware to correct the depth setting
> first.
>=20
> Best regards
> Uwe

My state of mind when posting the Tegra264 support series was that the=20
driver -- for the time being -- intentionally relies on the DEPTH=20
register being at reset value. As such I think it's fine to rely on that=20
everywhere for now. Once we add support for setting the register at=20
runtime, I think it makes sense to update all code paths at that time.

(Of course, I had intended to follow up with those patches sooner, but=20
..)

Mikko



