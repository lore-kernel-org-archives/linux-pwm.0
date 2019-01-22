From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2] pwm: Add MediaTek MT8183 display PWM driver support
Date: Tue, 22 Jan 2019 10:16:03 +0100
Message-ID: <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
References: <20190122090243.27304-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190122090243.27304-1-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, Sean Paul <seanpaul@chromium.org>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Andy Yan <andy.yan@rock-chips>
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMDU6MDI6NDNQTSArMDgwMCwgSml0YW8gU2hpIHdyb3Rl
Ogo+IFVzZSB0aGUgbXRrX3B3bV9kYXRhIHN0cnVjdGlvbiB0byBkZWZpbmUgZGlmZmVyZW50IHJl
Z2lzdGVycwo+IGFuZCBhZGQgTVQ4MTgzIHNwZWNpZmljIHJlZ2lzdGVyIG9wZXJhdGlvbnMsIHN1
Y2ggYXMgTVQ4MTgzCj4gZG9lc24ndCBoYXZlIGNvbW1pdCByZWdpc3RlciwgbmVlZHMgdG8gZGlz
YWJsZSBkb3VibGUgYnVmZmVyCj4gYmVmb3JlIHdyaXRpbmcgcmVnaXN0ZXIsIGFuZCBuZWVkcyB0
byBzZWxlY3QgY29tbWl0IG1vZGUKPiBhbmQgdXNlIFBXTV9QRVJJT0QvUFdNX0hJR0hfV0lEVEgu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPgoK
VGhlcmUgaXMgbm8gZGlmZmVyZW5jZSBjb21wYXJlZCB0byAoaW1wbGljaXQpIHYxIHNlbnQgYSBm
ZXcgbWludXRlcwplYXJsaWVyLCByaWdodD8gVGhlcmUgd2FzIGFub3RoZXIgcGF0Y2ggc2VudCB3
aXRoIHRoZSBzYW1lIFN1YmplY3QgbGFzdAp3ZWVrLCBzbyBJIGFzc3VtZSB0aGUgbWFpbCBmcm9t
IHRvZGF5IHdpdGhvdXQgInYyIiBpbiB0aGUgU3ViamVjdCB3YXMgYQptaXN0YWtlPwoKPiAtLS0K
QWRkaW5nIGEgcGFyYWdyYXBoIGJlbG93IHRoZSB0cmlwcGxlIGRhc2ggdGhhdCBwb2ludHMgb3V0
IHdoYXQgd2FzCmNoYW5nZWQgY29tcGFyZWQgdG8gdGhlIHByZXZpb3VzIHN1Ym1pc3Npb24gaXMg
YSBnb29kIGlkZWEgdG8gaGVscApyZXZpZXdlcnMgdG8gbW9yZSBlYXNpbHkgc2VlIHdoYXQgd2Fz
IGNoYW5nZWQuIEkgZ3Vlc3MgeW91IG9ubHkgYWRhcHRlZAp0aGUgY29tbWl0IGxvZyBhcyBhIHJl
YWN0aW9uIHRvIE1hdHRoaWFzIEJ1cmdnZXIncyByZXZpZXc/CgpCZXN0IHJlZ2FyZHMKVXdlCgot
LSAKUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWlu
ZS1Lw7ZuaWcgICAgICAgICAgICB8CkluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAg
ICAgICAgICB8IGh0dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
