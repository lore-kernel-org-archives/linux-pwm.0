From: Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH V2] pwm: Add MediaTek MT8183 display PWM driver support
Date: Tue, 22 Jan 2019 17:37:54 +0800
Message-ID: <1548149874.27796.3.camel@mszsdaap41>
References: <20190122090243.27304-1-jitao.shi@mediatek.com>
 <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, Sean Paul <seanpaul@chromium.org>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Andy Yan <andy.yan@rock-chip>
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTIyIGF0IDEwOjE2ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBPbiBUdWUsIEphbiAyMiwgMjAxOSBhdCAwNTowMjo0M1BNICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gPiBVc2UgdGhlIG10a19wd21fZGF0YSBzdHJ1Y3Rpb24gdG8gZGVmaW5lIGRpZmZl
cmVudCByZWdpc3RlcnMKPiA+IGFuZCBhZGQgTVQ4MTgzIHNwZWNpZmljIHJlZ2lzdGVyIG9wZXJh
dGlvbnMsIHN1Y2ggYXMgTVQ4MTgzCj4gPiBkb2Vzbid0IGhhdmUgY29tbWl0IHJlZ2lzdGVyLCBu
ZWVkcyB0byBkaXNhYmxlIGRvdWJsZSBidWZmZXIKPiA+IGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVy
LCBhbmQgbmVlZHMgdG8gc2VsZWN0IGNvbW1pdCBtb2RlCj4gPiBhbmQgdXNlIFBXTV9QRVJJT0Qv
UFdNX0hJR0hfV0lEVEguCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8u
c2hpQG1lZGlhdGVrLmNvbT4KPiAKPiBUaGVyZSBpcyBubyBkaWZmZXJlbmNlIGNvbXBhcmVkIHRv
IChpbXBsaWNpdCkgdjEgc2VudCBhIGZldyBtaW51dGVzCj4gZWFybGllciwgcmlnaHQ/IFRoZXJl
IHdhcyBhbm90aGVyIHBhdGNoIHNlbnQgd2l0aCB0aGUgc2FtZSBTdWJqZWN0IGxhc3QKPiB3ZWVr
LCBzbyBJIGFzc3VtZSB0aGUgbWFpbCBmcm9tIHRvZGF5IHdpdGhvdXQgInYyIiBpbiB0aGUgU3Vi
amVjdCB3YXMgYQo+IG1pc3Rha2U/Cj4gCj4gPiAtLS0KPiBBZGRpbmcgYSBwYXJhZ3JhcGggYmVs
b3cgdGhlIHRyaXBwbGUgZGFzaCB0aGF0IHBvaW50cyBvdXQgd2hhdCB3YXMKPiBjaGFuZ2VkIGNv
bXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzdWJtaXNzaW9uIGlzIGEgZ29vZCBpZGVhIHRvIGhlbHAK
PiByZXZpZXdlcnMgdG8gbW9yZSBlYXNpbHkgc2VlIHdoYXQgd2FzIGNoYW5nZWQuIEkgZ3Vlc3Mg
eW91IG9ubHkgYWRhcHRlZAo+IHRoZSBjb21taXQgbG9nIGFzIGEgcmVhY3Rpb24gdG8gTWF0dGhp
YXMgQnVyZ2dlcidzIHJldmlldz8KPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKClllcywgSSBt
aXNzIHRoZSAiVjIiIGFuZCBmaW5lIHR1bmUgdGhlIGNvbW1pdCBtZXNzYWdlLgoKQmVzdCBSZWdh
cmRzCkppdGFvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
